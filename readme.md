# ❄️ My NixOS Configuration

Welcome to my personal **NixOS** configuration repository. This setup manages my entire operating system, desktop environment, and user dotfiles in a fully declarative and reproducible way.

---

## ✨ Features

- **Nix Flakes**: Modern dependency management with locked package versions (`flake.lock`).
- **Home Manager**: Declarative configuration for user environments, CLI tools, and GUI dotfiles.
- **Storage Optimization**: Configured with `auto-optimise-store = true` to eliminate duplicate files.
- **System Maintenance**: Automated garbage collection to prevent disk space bloat.

---

## 📂 Repository Layout

```text
.
├── flake.nix                  # Main entry point defining inputs and outputs
├── flake.lock                 # Strict version lockfile for reproducible builds
├── configuration.nix          # Core system-level configuration
├── hardware-configuration.nix #
├── home-manager/              # User-level configurations and dotfiles
└── modules/                   # Reusable system modules or packages
```

---

## 🚀 Installation & Deployment

> ⚠️ **Warning:** Do not apply this configuration directly without updating the `hardware-configuration.nix` file to match your own machine's hardware, or your system will fail to boot.

### 1. Clone the repository

```bash
git clone https://github.com ~/.config/nixos
cd ~/.config/nixos
```

### 2. Generate your hardware configuration (For new machines)

Backup or overwrite the repository's hardware file with your own local setup:

```bash
sudo cp /etc/nixos/hardware-configuration.nix ~/.config/nixos/
```

### 3. Apply the configuration

Rebuild and switch to the system configuration using Flakes:

```bash
sudo nixos-rebuild switch --flake .#<your-host-name>
```

---

## 🛠️ Useful Commands

- **Update all packages and inputs:**
  ```bash
  nix flake update
  ```
- **Clean up old system generations to free up space:**
  ```bash
  nix-collect-garbage -d
  ```
- **Manually optimize the Nix store:**
  ```bash
  nix-store --optimise
  ```

---

## 🔍 Troubleshooting Sway

Get classname and appid:

  ```bash
  xprop WM_CLASS
  ```
  ```bash
  swaymsg -t get_tree | grep -E '"app_id"|"name"'
  ```
Live log niri
```
journalctl --user -u niri -f
```


## 👤 Author

- **GitHub:** [@minhz721](https://github.com)

Feel free to fork this repository or borrow snippets for your own NixOS journey!
