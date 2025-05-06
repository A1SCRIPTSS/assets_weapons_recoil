Config = {}

Config.Recoil = {
    Weights = {
        playerSpeed = 0.5,
        weaponRecoil = 0.3,
        aimMode = 0.2
    },
    SpeedMapping = {
        minSpeed = 0.0,
        maxSpeed = 150.0,
        minEffect = 1.0,
        maxEffect = 8.0
    }
}

Config.Durability = {
    enabled = true,
    thresholds = {
        low = 10,
        medium = 50
    },
    modifiers = {
        low = 1.25,
        medium = 1.15
    }
}

Config.Movement = {
    still = 0.8,
    walking = 1.0,
    running = 1.2
}

Config.Attachments = {
    suppressor = { modifier = 0.8, label = "Suppressor" },
    grip = { modifier = 0.85, label = "Grip" },
    extendedMag = { modifier = 1.05, label = "Extended Magazine" },
    drumMag = { modifier = 1.1, label = "Drum Magazine" },
    barrel = { modifier = 0.9, label = "Custom Barrel" },
    scope = { modifier = 1.0, label = "Scope" },
    flashlight = { modifier = 1.0, label = "Flashlight" }
}

Config.Weapons = {
    [GetHashKey("weapon_pistol50")] = {
        recoil = 50.0,
        type = "pistol",
        label = "Pistol .50",
        attachments = {
            suppressor = { modifier = 0.5, label = "Pistol Suppressor" },
            grip = { modifier = 0.85, label = "Pistol Grip" },
            extendedMag = { modifier = 1.03, label = "Extended Mag" },
            drumMag = { modifier = 1.15, label = "Drum Mag" },
            barrel = { modifier = 0.95, label = "Barrel" }
        }
    },
    [GetHashKey("weapon_smg")] = {
        recoil = 25.0,
        type = "smg",
        label = "Smg",
        attachments = {
            suppressor = { modifier = 0.5, label = "Pistol Suppressor" },
            grip = { modifier = 0.85, label = "Pistol Grip" },
            extendedMag = { modifier = 1.03, label = "Extended Mag" },
            drumMag = { modifier = 1.15, label = "Drum Mag" },
            barrel = { modifier = 0.95, label = "Barrel" }
        }
    },
}

Config.Debug = {
    enabled = true
}