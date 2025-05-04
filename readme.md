# Advanced Weapon Recoil System for FiveM

An optimized and customizable weapon recoil system for FiveM servers that dynamically adjusts recoil based on player behavior, weapon stats, and optional attachments.

---

## 🚀 Features

* **Dynamic Recoil Calculation**:

  * Player movement (idle, walk, run)
  * Aiming (ADS mode)
  * Weapon base recoil values
  * Weapon durability (increases recoil as condition degrades)
  * Attachment impact (grips, silencers, scopes, etc.)

* **Attachment System**:

  * Customizable modifiers for each type (grips, suppressors, scopes, lasers)
  * Metadata-based attachment detection via `ox_inventory`

* **Durability System**:

  * Recoil dynamically increases with weapon wear (optional)

* **Performance Optimized**:

  * Lightweight tick-based design
  * Cached states and delta-checks to reduce overhead

* **Debug Mode**:

  * Enable logging and real-time feedback during testing

* **200+ Preconfigured Weapons** ready to go

---

## 📦 Installation

1. Copy the resource folder into your server’s `resources` directory
2. Add the following line to your `server.cfg`:

   ```cfg
   ensure weapon_recoil
   ```
3. Edit the `config.lua` file to suit your desired gameplay and balancing

---

## ⚙️ Configuration

All settings are managed in `config.lua`. Example:

```lua
Config = {
    Recoil = {
        Weights = {
            playerSpeed = 0.5,     -- Influence of movement on recoil
            weaponRecoil = 0.3,    -- Influence of weapon's base recoil
            aimMode = 0.2          -- Reduction when aiming down sights
        },
        Durability = true,         -- Toggle recoil increase for weapon wear
    },
    Attachments = {
        silencer = -0.1,
        grip = -0.2,
        scope = -0.05
    },
    Debug = false                  -- Set to true for logging recoil changes
}
```

---

## 🧩 Dependencies

* [`ox_inventory`](https://github.com/overextended/ox_inventory) *(optional)*

  * Required for attachment metadata and durability support

---

## ✅ Compatibility

Tested with:

* FiveM (latest server build)
* `ox_inventory`
* Most weapon framework setups

---

## 🤝 Contributing

Pull requests and suggestions are welcome. Feel free to open issues for bugs or enhancements.

## 🙏 Credits

Inspired by and built upon the work from [peleg-development](https://github.com/peleg-development/peleg-Recoil)
---

## 📄 License

This project is licensed under the MIT License – see the [LICENSE](https://github.com/A1SCRIPTSS/assets_weapons_recoil/blob/main/LICENSE) file for details.