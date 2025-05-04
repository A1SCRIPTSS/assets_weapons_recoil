local playerPed = PlayerPedId()
local currentWeaponData = nil
local lastWeaponHash = nil
local lastSuppressorState = nil
local lastDurabilityModifier = 1.0
local lastMovementState = nil
local lastAimingState = nil
local lastAttachmentState = {}

local GetEntitySpeed = GetEntitySpeed
local IsPedRunning = IsPedRunning
local IsPedWalking = IsPedWalking
local IsPlayerFreeAiming = IsPlayerFreeAiming
local IsPedArmed = IsPedArmed
local GetCurrentPedWeapon = GetCurrentPedWeapon
local SetWeaponRecoilShakeAmplitude = SetWeaponRecoilShakeAmplitude
local PlayerId = PlayerId
local string_find = string.find
local pairs = pairs
local print = print

local speedWeight = Config.Recoil.Weights.playerSpeed
local recoilWeight = Config.Recoil.Weights.weaponRecoil
local aimReduction = Config.Recoil.Weights.aimMode

AddEventHandler('ox_inventory:currentWeapon', function(weapon)
    currentWeaponData = weapon
end)

local function CalculateAmplitudeScale(num, baseMin, baseMax, targetMin, targetMax)
    return (((num - baseMin) * (targetMax - targetMin)) / (baseMax - baseMin)) + targetMin
end

local function GetWeaponData(weaponHash)
    return Config.Weapons[weaponHash] or { 
        recoil = 3.5, 
        type = "generic", 
        label = "Unknown",
        attachments = {
            suppressor = Config.Attachments.suppressor,
            grip = Config.Attachments.grip,
            extendedMag = Config.Attachments.extendedMag,
            drumMag = Config.Attachments.drumMag,
            barrel = Config.Attachments.barrel,
            scope = Config.Attachments.scope,
            flashlight = Config.Attachments.flashlight
        }
    }
end

local function GetWeaponTypeData(weaponType)
    return Config.WeaponTypes[weaponType] or Config.WeaponTypes.generic
end

local function GetAttachmentEffects(components)
    if not components then return {} end
    
    local effects = {
        suppressor = false,
        grip = false,
        extendedMag = false,
        drumMag = false,
        barrel = false,
        scope = false,
        flashlight = false
    }
    
    for _, component in pairs(components) do
        local componentLower = component:lower()
        
        if string_find(componentLower, 'suppressor') or 
           string_find(componentLower, 'silencer') or 
           string_find(componentLower, 'compensator') then
            effects.suppressor = true
        
        elseif string_find(componentLower, 'grip') or 
               string_find(componentLower, 'handle') then
            effects.grip = true
        
        elseif string_find(componentLower, 'extended') or 
               string_find(componentLower, 'extmag') or 
               string_find(componentLower, 'large') and string_find(componentLower, 'mag') then
            effects.extendedMag = true
        
        elseif string_find(componentLower, 'drum') and string_find(componentLower, 'mag') then
            effects.drumMag = true
        
        elseif string_find(componentLower, 'barrel') or 
               string_find(componentLower, 'heavy') and string_find(componentLower, 'barrel') then
            effects.barrel = true
        
        elseif string_find(componentLower, 'scope') or 
               string_find(componentLower, 'sight') or 
               string_find(componentLower, 'optic') then
            effects.scope = true
        
        elseif string_find(componentLower, 'flashlight') or 
               string_find(componentLower, 'light') or 
               string_find(componentLower, 'laser') then
            effects.flashlight = true
        end
    end
    
    return effects
end

local function CalculateAttachmentModifiers(weaponData, attachments)
    local modifier = 1.0
    
    local weaponAttachments = weaponData.attachments or {
        suppressor = Config.Attachments.suppressor,
        grip = Config.Attachments.grip,
        extendedMag = Config.Attachments.extendedMag,
        drumMag = Config.Attachments.drumMag,
        barrel = Config.Attachments.barrel,
        scope = Config.Attachments.scope,
        flashlight = Config.Attachments.flashlight
    }
    
    for attachment, state in pairs(attachments) do
        if state and weaponAttachments[attachment] then
            modifier = modifier * weaponAttachments[attachment].modifier
        end
    end
    
    return modifier
end

local function GetDurabilityModifier(durability)
    if not durability then return 1.0 end
    
    if durability <= Config.Durability.thresholds.low then
        return Config.Durability.modifiers.low
    elseif durability <= Config.Durability.thresholds.medium then
        return Config.Durability.modifiers.medium
    end
    return 1.0
end

local function GetMovementModifier(ped)
    if IsPedRunning(ped) then
        return Config.Movement.running
    elseif IsPedWalking(ped) then
        return Config.Movement.walking
    end
    return Config.Movement.still
end

local function LogDebugChanges(weapon, weaponData, attachments, durabilityModifier, amplitude)
    local shouldDebug = false
    local debugMsg = ""
    
    if weapon ~= lastWeaponHash then
        shouldDebug = true
        if Config.Debug.enabled and Config.Debug.showWeaponChanges then
            debugMsg = debugMsg .. ('[RECOIL] Weapon Changed: %s (%s)\n'):format(weaponData.label, weapon)
        end
    end

    for attachment, state in pairs(attachments) do
        if lastAttachmentState[attachment] ~= state then
            shouldDebug = true
            if Config.Debug.enabled and Config.Debug.showAttachmentChanges then
                local attachmentData = (weaponData.attachments and weaponData.attachments[attachment]) or Config.Attachments[attachment]
                debugMsg = debugMsg .. ('[RECOIL] %s: %s (Modifier: %.2f)\n'):format(
                    attachmentData.label or attachment:upper(),
                    state and 'ATTACHED' or 'DETACHED',
                    attachmentData.modifier
                )
            end
        end
    end

    if durabilityModifier ~= lastDurabilityModifier then
        shouldDebug = true
        if Config.Debug.enabled and Config.Debug.showDurabilityEffects then
            debugMsg = debugMsg .. ('[RECOIL] Durability Effect: %.0f%% more recoil\n'):format((durabilityModifier - 1) * 100)
        end
    end

    if shouldDebug and Config.Debug.enabled then
        debugMsg = debugMsg .. ('[RECOIL] Final Recoil Applied: %.2f\n'):format(amplitude)
        print(debugMsg)
    end
end

function ApplyRecoilBasedOnStateOrSpeed(ped, weapon, modifier)
    local weaponData = GetWeaponData(weapon)
    local weaponTypeData = GetWeaponTypeData(weaponData.type)
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

    if exports.ox_inventory then
        local weaponItem = currentWeaponData or exports.ox_inventory:getCurrentWeapon()

        if weaponItem then
            if not weaponItem.melee and weaponItem.metadata.components then
                attachments = GetAttachmentEffects(weaponItem.metadata.components)
            end

            if Config.Durability.enabled and weaponItem.metadata and weaponItem.metadata.durability then
                durabilityModifier = GetDurabilityModifier(weaponItem.metadata.durability)
            end
        end
    end

    local pedSpeed = GetEntitySpeed(ped)
    local movementModifier = GetMovementModifier(ped)

    local amplitude = CalculateAmplitudeScale(
        pedSpeed,
        Config.Recoil.SpeedMapping.minSpeed,
        Config.Recoil.SpeedMapping.maxSpeed,
        Config.Recoil.SpeedMapping.minEffect,
        Config.Recoil.SpeedMapping.maxEffect
    ) * speedWeight

    amplitude = amplitude + CalculateAmplitudeScale(
        weaponData.recoil,
        Config.Recoil.RecoilMapping.minRecoil,
        Config.Recoil.RecoilMapping.maxRecoil,
        Config.Recoil.RecoilMapping.minEffect,
        Config.Recoil.RecoilMapping.maxEffect
    ) * recoilWeight

    local isAiming = IsPlayerFreeAiming(PlayerId())
    if isAiming then
        amplitude = amplitude * (1 - aimReduction)
    end

    local attachmentModifier = CalculateAttachmentModifiers(weaponData, attachments)

    amplitude = amplitude * weaponTypeData.modifier * movementModifier * modifier * durabilityModifier * attachmentModifier

    SetWeaponRecoilShakeAmplitude(weapon, amplitude)

    if Config.Debug.enabled then
        LogDebugChanges(weapon, weaponData, attachments, durabilityModifier, amplitude)
    end

    lastWeaponHash = weapon
    lastAttachmentState = attachments
    lastDurabilityModifier = durabilityModifier
    lastMovementState = movementModifier
    lastAimingState = isAiming
end

CreateThread(function()
    while true do
        Wait(150)
        
        local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
            local _, currentWeapon = GetCurrentPedWeapon(ped, true)
            ApplyRecoilBasedOnStateOrSpeed(ped, currentWeapon, 1.0)
        end
    end
end)