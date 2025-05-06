local PlayerPedId = PlayerPedId
local GetEntitySpeed = GetEntitySpeed
local IsPedRunning = IsPedRunning
local IsPedWalking = IsPedWalking
local IsPlayerFreeAiming = IsPlayerFreeAiming
local IsPedArmed = IsPedArmed
local GetCurrentPedWeapon = GetCurrentPedWeapon
local SetWeaponRecoilShakeAmplitude = SetWeaponRecoilShakeAmplitude
local PlayerId = PlayerId
local GetGameTimer = GetGameTimer
local string_find = string.find
local pairs = pairs
local ipairs = ipairs
local print = print
local type = type
local math_min = math.min
local math_max = math.max
local math_abs = math.abs
local table_type = type

local Config = Config
local speedWeight = Config.Recoil.Weights.playerSpeed
local recoilWeight = Config.Recoil.Weights.weaponRecoil
local aimReduction = Config.Recoil.Weights.aimMode
local durabilityThresholds = Config.Durability.thresholds
local durabilityModifiers = Config.Durability.modifiers
local movementModifiers = Config.Movement
local recoilSpeedMapping = Config.Recoil.SpeedMapping
local recoilRecoilMapping = Config.Recoil.RecoilMapping
local defaultAttachments = Config.Attachments

local currentWeapon = nil
local lastWeaponHash = nil
local lastDurabilityModifier = 1.0
local lastAttachmentState = {}
local lastRecoilValue = 0

local defaultWeaponData = {
    recoil = 3.5,
    type = "generic",
    label = "Unknown",
    attachments = defaultAttachments
}

local emptyAttachmentEffects = {
    suppressor = false,
    grip = false,
    extendedMag = false,
    drumMag = false,
    barrel = false,
    scope = false,
    flashlight = false
}

local attachmentPatterns = {
    suppressor = {
        { pattern = 'suppressor', len = 9 },
        { pattern = 'silencer', len = 8 },
        { pattern = 'compensator', len = 11 }
    },
    grip = {
        { pattern = 'grip', len = 4 },
        { pattern = 'handle', len = 6 }
    },
    extendedMag = {
        { pattern = 'extended', len = 8 },
        { pattern = 'extmag', len = 6 },
        { pattern = 'large.*mag', len = 6 }
    },
    drumMag = {
        { pattern = 'drum.*mag', len = 5 }
    },
    barrel = {
        { pattern = 'barrel', len = 6 },
        { pattern = 'heavy.*barrel', len = 6 }
    },
    scope = {
        { pattern = 'scope', len = 5 },
        { pattern = 'sight', len = 5 },
        { pattern = 'optic', len = 5 }
    },
    flashlight = {
        { pattern = 'flashlight', len = 10 },
        { pattern = 'light', len = 5 },
        { pattern = 'laser', len = 5 }
    }
}

local reusableAttachmentTable = {
    suppressor = false,
    grip = false,
    extendedMag = false,
    drumMag = false,
    barrel = false,
    scope = false,
    flashlight = false
}

local playerId = PlayerId()

AddEventHandler('ox_inventory:currentWeapon', function(weapon)
    currentWeapon = (weapon and type(weapon) == 'table') and weapon or nil
end)

local function CalculateAmplitudeScale(num, baseMin, baseMax, targetMin, targetMax)
    if baseMax == baseMin then return targetMin end
    num = math_min(math_max(num, baseMin), baseMax)
    return ((num - baseMin) * (targetMax - targetMin) / (baseMax - baseMin)) + targetMin
end

local function GetWeaponData(weaponHash)
    return Config.Weapons[weaponHash] or defaultWeaponData
end

local function GetWeaponTypeData(weaponType)
    return Config.WeaponTypes[weaponType] or Config.WeaponTypes.generic
end

local function GetAttachmentEffects(components)
    if not components or table_type(components) ~= 'table' then return emptyAttachmentEffects end
    for k in pairs(reusableAttachmentTable) do reusableAttachmentTable[k] = false end
    for i = 1, #components do
        local component = components[i]
        if table_type(component) == 'string' then
            local componentLower = component:lower()
            for attachmentType, patterns in pairs(attachmentPatterns) do
                if not reusableAttachmentTable[attachmentType] then
                    for j = 1, #patterns do
                        local pattern = patterns[j]
                        if #componentLower >= pattern.len and string_find(componentLower, pattern.pattern) then
                            reusableAttachmentTable[attachmentType] = true
                            break
                        end
                    end
                end
            end
        end
    end
    return reusableAttachmentTable
end

local function CalculateAttachmentModifiers(weaponData, attachments)
    local modifier = 1.0
    for attachment, state in pairs(attachments) do
        if state then
            local attachData = nil
            if weaponData.attachments and weaponData.attachments[attachment] then
                attachData = weaponData.attachments[attachment]
            elseif defaultAttachments[attachment] then
                attachData = defaultAttachments[attachment]
            end
            if attachData and attachData.modifier then
                modifier = modifier * attachData.modifier
            end
        end
    end
    return modifier
end

local function GetDurabilityModifier(durability)
    if not durability or table_type(durability) ~= 'number' then return 1.0 end
    if durability <= durabilityThresholds.low then
        return durabilityModifiers.low
    elseif durability <= durabilityThresholds.medium then
        return durabilityModifiers.medium
    end
    return 1.0
end

local function GetMovementModifier(ped)
    if IsPedRunning(ped) then
        return movementModifiers.running
    elseif IsPedWalking(ped) then
        return movementModifiers.walking
    end
    return movementModifiers.still
end

local function LogDebugChanges(weaponHash, weaponData, attachments, durabilityModifier, amplitude)
    if not Config.Debug.enabled then return end
    local debugMsg = ""
    local hasChanges = false

    if weaponHash ~= lastWeaponHash then
        debugMsg = debugMsg .. string.format("[RECOIL DEBUG] Weapon Changed: %s (Hash: %s)\n", weaponData.label, weaponHash)
        hasChanges = true
    end

    for attachment, state in pairs(attachments) do
        if lastAttachmentState[attachment] ~= state then
            local attachmentData = (weaponData.attachments and weaponData.attachments[attachment]) or defaultAttachments[attachment]
            local effect = state and "INCREASED" or "DECREASED"
            if attachmentData.modifier < 1 then
                effect = state and "DECREASED" or "INCREASED"
            end
            debugMsg = debugMsg .. string.format("[RECOIL DEBUG] %s %s: %s (Modifier: %.2f -> %s recoil)\n",
                attachmentData.label or attachment:upper(),
                state and "ATTACHED" or "DETACHED",
                effect,
                attachmentData.modifier,
                state and "APPLIED" or "REMOVED")
            hasChanges = true
        end
    end

    if durabilityModifier ~= lastDurabilityModifier then
        local change = durabilityModifier > lastDurabilityModifier and "INCREASED" or "DECREASED"
        debugMsg = debugMsg .. string.format("[RECOIL DEBUG] Durability effect %s: %.0f%% more recoil\n",
            change, (durabilityModifier - 1) * 100)
        hasChanges = true
    end

    if math_abs(amplitude - lastRecoilValue) > 0.01 then
        local change = amplitude > lastRecoilValue and "INCREASED" or "DECREASED"
        debugMsg = debugMsg .. string.format("[RECOIL DEBUG] Recoil %s from %.2f to %.2f (%.2f%% change)\n",
            change,
            lastRecoilValue,
            amplitude,
            ((amplitude - lastRecoilValue) / math_max(lastRecoilValue, 0.01)) * 100)
        hasChanges = true
    end

    if hasChanges then
        debugMsg = debugMsg .. string.format("[RECOIL DEBUG] Final Recoil Applied: %.2f\n", amplitude)
        print(debugMsg)
    end

    lastWeaponHash = weaponHash
    lastAttachmentState = attachments
    lastDurabilityModifier = durabilityModifier
    lastRecoilValue = amplitude
end

local function ApplyRecoilBasedOnStateOrSpeed(ped, weaponHash, modifier)
    local weaponData = Config.Weapons[weaponHash] or {
        recoil = 3.5,
        type = "generic",
        label = "Unknown",
        attachments = Config.Attachments
    }

    local durabilityModifier = 1.0
    local attachments = {
        suppressor = false,
        grip = false,
        extendedMag = false,
        drumMag = false,
        barrel = false,
        scope = false,
        flashlight = false
    }

    if currentWeapon and type(currentWeapon) == 'table' then
        if currentWeapon.metadata then
            if currentWeapon.metadata.components then
                attachments = GetAttachmentEffects(currentWeapon.metadata.components)
            end
            if Config.Durability.enabled and currentWeapon.metadata.durability then
                durabilityModifier = GetDurabilityModifier(currentWeapon.metadata.durability)
            end
        end
    end

    local pedSpeed = GetEntitySpeed(ped) * 3.6
    local movementModifier = GetMovementModifier(ped)

    local speedEffect = CalculateAmplitudeScale(
        pedSpeed,
        Config.Recoil.SpeedMapping.minSpeed,
        Config.Recoil.SpeedMapping.maxSpeed,
        Config.Recoil.SpeedMapping.minEffect,
        Config.Recoil.SpeedMapping.maxEffect
    ) * Config.Recoil.Weights.playerSpeed

    local weaponRecoilEffect = weaponData.recoil * Config.Recoil.Weights.weaponRecoil

    local amplitude = speedEffect + weaponRecoilEffect

    if IsPlayerFreeAiming(PlayerId()) then
        amplitude = amplitude * (1 - Config.Recoil.Weights.aimMode)
    end

    local attachmentModifier = CalculateAttachmentModifiers(weaponData, attachments)
    amplitude = amplitude * movementModifier * modifier * durabilityModifier * attachmentModifier
    amplitude = math.max(amplitude, 0.1)

    SetWeaponRecoilShakeAmplitude(weaponHash, amplitude)

    if Config.Debug.enabled then
        LogDebugChanges(weaponHash, weaponData, attachments, durabilityModifier, amplitude)
    end
end

CreateThread(function()
    local lastCheck = 0
    local checkInterval = 200 
    while true do
        local currentTime = GetGameTimer()
        if currentTime - lastCheck >= checkInterval then
            lastCheck = currentTime
            local ped = PlayerPedId()
            local hasWeapon, currentWeaponHash = GetCurrentPedWeapon(ped, true)
            if hasWeapon and IsPedArmed(ped, 6) then
                ApplyRecoilBasedOnStateOrSpeed(ped, currentWeaponHash, 1.0)
            else
                SetWeaponRecoilShakeAmplitude(0, 0.0)
                lastRecoilValue = 0
            end
        end
        Wait(0)
    end
end)