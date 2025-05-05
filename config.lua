Config = {}

Config.Recoil = {
    -- Base weights for different factors affecting recoil
    Weights = {
        playerSpeed = 0.5,     -- How much player movement speed affects recoil
        weaponRecoil = 0.3,    -- How much the weapon's base recoil value affects the result
        aimMode = 0.2          -- How much aiming down sights reduces recoil (0.2 = 20% reduction)
    },

    -- Speed range mapping for recoil calculation (min/max speed vs min/max recoil effect)
    SpeedMapping = {
        minSpeed = 0.0,        -- Minimum player speed (standing still)
        maxSpeed = 150.0,      -- Maximum player speed to consider
        minEffect = 1.0,       -- Minimum recoil effect at min speed
        maxEffect = 8.0        -- Maximum recoil effect at max speed
    },

    -- Weapon recoil value mapping (min/max recoil vs min/max effect)
    RecoilMapping = {
        minRecoil = 0.0,       -- Minimum weapon recoil value
        maxRecoil = 10.0,      -- Maximum weapon recoil value
        minEffect = 1.0,       -- Minimum effect at min recoil
        maxEffect = 5.0        -- Maximum effect at max recoil
    }
}

Config.Durability = {
    enabled = true,             -- Set to false to disable durability effects
    thresholds = {
        low = 10,               -- Durability threshold for maximum recoil penalty
        medium = 50             -- Durability threshold for moderate recoil penalty
    },
    modifiers = {
        low = 1.25,             -- 25% more recoil when durability <= 10
        medium = 1.15           -- 15% more recoil when durability <= 50
    }
}

Config.Movement = {
    still = 0.8,       -- Recoil multiplier when standing still
    walking = 1.0,     -- Recoil multiplier when walking
    running = 1.2      -- Recoil multiplier when running
}

Config.Attachments = {
    suppressor = {
        modifier = 0.8,
        label = "Suppressor"
    },
    grip = {
        modifier = 0.85,
        label = "Grip"
    },
    extendedMag = {
        modifier = 1.05,
        label = "Extended Magazine"
    },
    drumMag = {
        modifier = 1.1,
        label = "Drum Magazine"
    },
    barrel = {
        modifier = 0.9,
        label = "Custom Barrel"
    },
    scope = {
        modifier = 1.0,
        label = "Scope"
    },
    flashlight = {
        modifier = 1.0,
        label = "Flashlight"
    }
}

Config.Weapons = {
    ["weapon_pistol"] = {
        recoil = 1.5,
        type = "pistol",
        label = "Pistol",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Pistol Suppressor"
            },
            extendedMag = {
                modifier = 1.03,
                label = "Pistol Extended Mag"
            },
            drumMag = {
                modifier = 1.15,
                label = "Pistol Drum Mag"
            },
            barrel = {
                modifier = 0.95,
                label = "Pistol Barrel"
            }
        }
    },
    ["weapon_pistol_mk2"] = {
        recoil = 1.3,
        type = "pistol",
        label = "Pistol Mk II",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Pistol Suppressor"
            },
            extendedMag = {
                modifier = 1.03,
                label = "Pistol Extended Mag"
            },
            drumMag = {
                modifier = 1.15,
                label = "Pistol Drum Mag"
            },
            barrel = {
                modifier = 0.95,
                label = "Pistol Barrel"
            }
        }
    },
    ["weapon_combatpistol"] = {
        recoil = 1.2,
        type = "pistol",
        label = "Combat Pistol",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Pistol Suppressor"
            },
            extendedMag = {
                modifier = 1.03,
                label = "Pistol Extended Mag"
            },
            drumMag = {
                modifier = 1.15,
                label = "Pistol Drum Mag"
            },
            barrel = {
                modifier = 0.95,
                label = "Pistol Barrel"
            }
        }
    },
    ["weapon_appistol"] = {
        recoil = 1.0,
        type = "pistol",
        label = "AP Pistol",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Pistol Suppressor"
            },
            extendedMag = {
                modifier = 1.03,
                label = "Pistol Extended Mag"
            },
            drumMag = {
                modifier = 1.15,
                label = "Pistol Drum Mag"
            },
            barrel = {
                modifier = 0.95,
                label = "Pistol Barrel"
            }
        }
    },
    ["weapon_pistol50"] = { 
        recoil = 4.0, 
        type = "pistol",
        label = "Pistol .50",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Pistol Suppressor"
            },
            grip = {
                modifier = 1.9,
                label = "Pistol Grip"
            },
            extendedMag = {
                modifier = 1.03,
                label = "Pistol Extended Mag"
            },
            drumMag = {
                modifier = 1.15,
                label = "Pistol Drum Mag"
            },
            barrel = {
                modifier = 0.95,
                label = "Pistol Barrel"
            }
        }
    },
    ["weapon_snspistol"] = {
        recoil = 1.8,
        type = "pistol",
        label = "SNS Pistol",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Pistol Suppressor"
            },
            extendedMag = {
                modifier = 1.03,
                label = "Pistol Extended Mag"
            },
            drumMag = {
                modifier = 1.15,
                label = "Pistol Drum Mag"
            },
            barrel = {
                modifier = 0.95,
                label = "Pistol Barrel"
            }
        }
    },
    ["weapon_snspistol_mk2"] = {
        recoil = 1.6,
        type = "pistol",
        label = "SNS Pistol Mk II",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Pistol Suppressor"
            },
            extendedMag = {
                modifier = 1.03,
                label = "Pistol Extended Mag"
            },
            drumMag = {
                modifier = 1.15,
                label = "Pistol Drum Mag"
            },
            barrel = {
                modifier = 0.95,
                label = "Pistol Barrel"
            }
        }
    },
    ["weapon_heavypistol"] = {
        recoil = 1.4,
        type = "pistol",
        label = "Heavy Pistol",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Pistol Suppressor"
            },
            extendedMag = {
                modifier = 1.03,
                label = "Pistol Extended Mag"
            },
            drumMag = {
                modifier = 1.15,
                label = "Pistol Drum Mag"
            },
            barrel = {
                modifier = 0.95,
                label = "Pistol Barrel"
            }
        }
    },
    ["weapon_vintagepistol"] = {
        recoil = 1.7,
        type = "pistol",
        label = "Vintage Pistol",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Pistol Suppressor"
            },
            extendedMag = {
                modifier = 1.03,
                label = "Pistol Extended Mag"
            },
            drumMag = {
                modifier = 1.15,
                label = "Pistol Drum Mag"
            },
            barrel = {
                modifier = 0.95,
                label = "Pistol Barrel"
            }
        }
    },
    ["weapon_microsmg"] = {
        recoil = 0.7,
        type = "smg",
        label = "Micro SMG",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "SMG Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "SMG Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "SMG Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "SMG Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "SMG Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "SMG Scope"
            }
        }
    },
    ["weapon_smg"] = {
        recoil = 0.5,
        type = "smg",
        label = "SMG",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "SMG Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "SMG Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "SMG Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "SMG Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "SMG Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "SMG Scope"
            }
        }
    },
    ["weapon_smg_mk2"] = {
        recoil = 0.4,
        type = "smg",
        label = "SMG Mk II",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "SMG Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "SMG Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "SMG Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "SMG Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "SMG Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "SMG Scope"
            }
        }
    },
    ["weapon_assaultsmg"] = {
        recoil = 0.45,
        type = "smg",
        label = "Assault SMG",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "SMG Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "SMG Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "SMG Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "SMG Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "SMG Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "SMG Scope"
            }
        }
    },
    ["weapon_combatpdw"] = {
        recoil = 0.4,
        type = "smg",
        label = "Combat PDW",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "SMG Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "SMG Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "SMG Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "SMG Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "SMG Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "SMG Scope"
            }
        }
    },
    ["weapon_machinepistol"] = {
        recoil = 0.6,
        type = "smg",
        label = "Machine Pistol",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "SMG Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "SMG Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "SMG Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "SMG Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "SMG Barrel"
            }
        }
    },
    ["weapon_minismg"] = {
        recoil = 0.55,
        type = "smg",
        label = "Mini SMG",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "SMG Suppressor"
            },
            extendedMag = {
                modifier = 1.05,
                label = "SMG Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "SMG Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "SMG Barrel"
            }
        }
    },
    ["weapon_pumpshotgun"] = {
        recoil = 1.0,
        type = "shotgun",
        label = "Pump Shotgun",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Shotgun Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "Shotgun Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "Shotgun Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "Shotgun Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "Shotgun Barrel"
            }
        }
    },
    ["weapon_pumpshotgun_mk2"] = {
        recoil = 0.9,
        type = "shotgun",
        label = "Pump Shotgun Mk II",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Shotgun Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "Shotgun Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "Shotgun Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "Shotgun Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "Shotgun Barrel"
            }
        }
    },
    ["weapon_assaultshotgun"] = {
        recoil = 0.8,
        type = "shotgun",
        label = "Assault Shotgun",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Shotgun Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "Shotgun Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "Shotgun Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "Shotgun Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "Shotgun Barrel"
            }
        }
    },
    ["weapon_bullpupshotgun"] = {
        recoil = 0.7,
        type = "shotgun",
        label = "Bullpup Shotgun",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Shotgun Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "Shotgun Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "Shotgun Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "Shotgun Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "Shotgun Barrel"
            }
        }
    },
    ["weapon_heavyshotgun"] = {
        recoil = 0.6,
        type = "shotgun",
        label = "Heavy Shotgun",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Shotgun Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "Shotgun Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "Shotgun Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "Shotgun Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "Shotgun Barrel"
            }
        }
    },
    ["weapon_assaultrifle"] = {
        recoil = 0.5,
        type = "rifle",
        label = "Assault Rifle",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Rifle Suppressor"
            },
            grip = {
                modifier = 0.8,
                label = "Vertical Grip"
            },
            extendedMag = {
                modifier = 1.07,
                label = "Rifle Extended Mag"
            },
            drumMag = {
                modifier = 1.12,
                label = "Rifle Drum Mag"
            },
            barrel = {
                modifier = 0.85,
                label = "Heavy Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Rifle Scope"
            }
        }
    },
    ["weapon_assaultrifle_mk2"] = {
        recoil = 0.4,
        type = "rifle",
        label = "Assault Rifle Mk II",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Rifle Suppressor"
            },
            grip = {
                modifier = 0.8,
                label = "Vertical Grip"
            },
            extendedMag = {
                modifier = 1.07,
                label = "Rifle Extended Mag"
            },
            drumMag = {
                modifier = 1.12,
                label = "Rifle Drum Mag"
            },
            barrel = {
                modifier = 0.85,
                label = "Heavy Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Rifle Scope"
            }
        }
    },
    ["weapon_carbinerifle"] = {
        recoil = 0.4,
        type = "rifle",
        label = "Carbine Rifle",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Rifle Suppressor"
            },
            grip = {
                modifier = 0.8,
                label = "Vertical Grip"
            },
            extendedMag = {
                modifier = 1.07,
                label = "Rifle Extended Mag"
            },
            drumMag = {
                modifier = 1.12,
                label = "Rifle Drum Mag"
            },
            barrel = {
                modifier = 0.85,
                label = "Heavy Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Rifle Scope"
            }
        }
    },
    ["weapon_carbinerifle_mk2"] = {
        recoil = 0.35,
        type = "rifle",
        label = "Carbine Rifle Mk II",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Rifle Suppressor"
            },
            grip = {
                modifier = 0.8,
                label = "Vertical Grip"
            },
            extendedMag = {
                modifier = 1.07,
                label = "Rifle Extended Mag"
            },
            drumMag = {
                modifier = 1.12,
                label = "Rifle Drum Mag"
            },
            barrel = {
                modifier = 0.85,
                label = "Heavy Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Rifle Scope"
            }
        }
    },
    ["weapon_advancedrifle"] = {
        recoil = 0.3,
        type = "rifle",
        label = "Advanced Rifle",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Rifle Suppressor"
            },
            grip = {
                modifier = 0.8,
                label = "Vertical Grip"
            },
            extendedMag = {
                modifier = 1.07,
                label = "Rifle Extended Mag"
            },
            drumMag = {
                modifier = 1.12,
                label = "Rifle Drum Mag"
            },
            barrel = {
                modifier = 0.85,
                label = "Heavy Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Rifle Scope"
            }
        }
    },
    ["weapon_specialcarbine"] = {
        recoil = 0.35,
        type = "rifle",
        label = "Special Carbine",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Rifle Suppressor"
            },
            grip = {
                modifier = 0.8,
                label = "Vertical Grip"
            },
            extendedMag = {
                modifier = 1.07,
                label = "Rifle Extended Mag"
            },
            drumMag = {
                modifier = 1.12,
                label = "Rifle Drum Mag"
            },
            barrel = {
                modifier = 0.85,
                label = "Heavy Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Rifle Scope"
            }
        }
    },
    ["weapon_specialcarbine_mk2"] = {
        recoil = 0.3,
        type = "rifle",
        label = "Special Carbine Mk II",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Rifle Suppressor"
            },
            grip = {
                modifier = 0.8,
                label = "Vertical Grip"
            },
            extendedMag = {
                modifier = 1.07,
                label = "Rifle Extended Mag"
            },
            drumMag = {
                modifier = 1.12,
                label = "Rifle Drum Mag"
            },
            barrel = {
                modifier = 0.85,
                label = "Heavy Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Rifle Scope"
            }
        }
    },
    ["weapon_bullpuprifle"] = {
        recoil = 0.4,
        type = "rifle",
        label = "Bullpup Rifle",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Rifle Suppressor"
            },
            grip = {
                modifier = 0.8,
                label = "Vertical Grip"
            },
            extendedMag = {
                modifier = 1.07,
                label = "Rifle Extended Mag"
            },
            drumMag = {
                modifier = 1.12,
                label = "Rifle Drum Mag"
            },
            barrel = {
                modifier = 0.85,
                label = "Heavy Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Rifle Scope"
            }
        }
    },
    ["weapon_bullpuprifle_mk2"] = {
        recoil = 0.35,
        type = "rifle",
        label = "Bullpup Rifle Mk II",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Rifle Suppressor"
            },
            grip = {
                modifier = 0.8,
                label = "Vertical Grip"
            },
            extendedMag = {
                modifier = 1.07,
                label = "Rifle Extended Mag"
            },
            drumMag = {
                modifier = 1.12,
                label = "Rifle Drum Mag"
            },
            barrel = {
                modifier = 0.85,
                label = "Heavy Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Rifle Scope"
            }
        }
    },
    ["weapon_compactrifle"] = {
        recoil = 0.3,
        type = "rifle",
        label = "Military Rifle",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Rifle Suppressor"
            },
            grip = {
                modifier = 0.8,
                label = "Vertical Grip"
            },
            extendedMag = {
                modifier = 1.07,
                label = "Rifle Extended Mag"
            },
            drumMag = {
                modifier = 1.12,
                label = "Rifle Drum Mag"
            },
            barrel = {
                modifier = 0.85,
                label = "Heavy Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Rifle Scope"
            }
        }
    },
    ["weapon_militaryrifle"] = {
        recoil = 0.3,
        type = "rifle",
        label = "Military Rifle",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Rifle Suppressor"
            },
            grip = {
                modifier = 0.8,
                label = "Vertical Grip"
            },
            extendedMag = {
                modifier = 1.07,
                label = "Rifle Extended Mag"
            },
            drumMag = {
                modifier = 1.12,
                label = "Rifle Drum Mag"
            },
            barrel = {
                modifier = 0.85,
                label = "Heavy Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Rifle Scope"
            }
        }
    },
    ["weapon_heavyrifle"] = {
        recoil = 0.3,
        type = "rifle",
        label = "Military Rifle",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Rifle Suppressor"
            },
            grip = {
                modifier = 0.8,
                label = "Vertical Grip"
            },
            extendedMag = {
                modifier = 1.07,
                label = "Rifle Extended Mag"
            },
            drumMag = {
                modifier = 1.12,
                label = "Rifle Drum Mag"
            },
            barrel = {
                modifier = 0.85,
                label = "Heavy Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Rifle Scope"
            }
        }
    },
    ["weapon_mg"] = {
        recoil = 0.2,
        type = "mg",
        label = "MG",
        attachments = {
            grip = {
                modifier = 0.9,
                label = "MG Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "MG Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "MG Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "MG Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "MG Scope"
            }
        }
    },
    ["weapon_combatmg"] = {
        recoil = 0.15,
        type = "mg",
        label = "Combat MG",
        attachments = {
            grip = {
                modifier = 0.9,
                label = "MG Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "MG Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "MG Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "MG Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "MG Scope"
            }
        }
    },
    ["weapon_combatmg_mk2"] = {
        recoil = 0.1,
        type = "mg",
        label = "Combat MG Mk II",
        attachments = {
            grip = {
                modifier = 0.9,
                label = "MG Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "MG Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "MG Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "MG Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "MG Scope"
            }
        }
    },
    ["weapon_sniperrifle"] = {
        recoil = 0.1,
        type = "sniper",
        label = "Sniper Rifle",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Sniper Suppressor"
            },
            extendedMag = {
                modifier = 1.05,
                label = "Sniper Extended Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "Sniper Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Sniper Scope"
            }
        }
    },
    ["weapon_heavysniper"] = {
        recoil = 1.5,
        type = "sniper",
        label = "Heavy Sniper",
        attachments = {
            scope = {
                modifier = 1.0,
                label = "Sniper Scope"
            }
        }
    },
    ["weapon_heavysniper_mk2"] = {
        recoil = 1.3,
        type = "sniper",
        label = "Heavy Sniper Mk II",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Sniper Suppressor"
            },
            barrel = {
                modifier = 0.9,
                label = "Sniper Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Sniper Scope"
            }
        }
    },
    ["weapon_marksmanrifle"] = {
        recoil = 0.2,
        type = "sniper",
        label = "Marksman Rifle",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Sniper Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "Sniper Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "Sniper Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "Sniper Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "Sniper Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Sniper Scope"
            }
        }
    },
    ["weapon_marksmanrifle_mk2"] = {
        recoil = 0.15,
        type = "sniper",
        label = "Marksman Rifle Mk II",
        attachments = {
            suppressor = {
                modifier = 0.8,
                label = "Sniper Suppressor"
            },
            grip = {
                modifier = 0.9,
                label = "Sniper Grip"
            },
            extendedMag = {
                modifier = 1.05,
                label = "Sniper Extended Mag"
            },
            drumMag = {
                modifier = 1.1,
                label = "Sniper Drum Mag"
            },
            barrel = {
                modifier = 0.9,
                label = "Sniper Barrel"
            },
            scope = {
                modifier = 1.0,
                label = "Sniper Scope"
            }
        }
    },
}

Config.WeaponTypes = {
    pistol = {
        modifier = 5
    },
    rifle = {
        modifier = 5
    },
    shotgun = {
        modifier = 5
    },
    smg = {
        modifier = 5
    },
    generic = {
        modifier = 5
    }
}

Config.Debug = {
    enabled = true,   
    showWeaponChanges = true,
    showAttachmentChanges = true,
    showDurabilityEffects = true
}