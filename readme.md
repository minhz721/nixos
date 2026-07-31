# ❄️ My NixOS Configuration

Welcome to my personal **NixOS** configuration repository. This setup manages my entire operating system, desktop environment, and user dotfiles in a fully declarative and reproducible way.

---

## ✨ Features

* **Nix Flakes**: Modern dependency management with locked package versions (`flake.lock`).
* **Home Manager**: Declarative configuration for user environments, CLI tools, and GUI dotfiles.
* **Niri Compositor**: A scrollable-tiling Wayland window manager focused on smooth animations.
* **Storage Optimization**: Configured with `auto-optimise-store = true` to eliminate duplicate files.
* **System Maintenance**: Automated garbage collection to prevent disk space bloat.

---

## 📂 Repository Layout

```text
.
├── flake.nix                  # Main entry point defining inputs and outputs
├── flake.lock                 # Strict version lockfile for reproducible builds
├── configuration.nix          # Core system-level configuration
├── hardware-configuration.nix # Hardware-specific configuration (auto-generated)
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
cp /etc/nixos/hardware-configuration.nix ~/.config/nixos/
```

### 3. Apply the configuration
Rebuild and switch to the system configuration using Flakes:
```bash
sudo nixos-rebuild switch --flake .#<your-host-name>
```

---

## 🛠️ Useful Commands

* **Update all packages and inputs:**
  ```bash
  nix flake update
  ```
* **Clean up old system generations to free up space:**
  ```bash
  nix-collect-garbage -d
  ```
* **Manually optimize the Nix store:**
  ```bash
  nix-store --optimise
  ```

---

## 🔍 Troubleshooting Niri

If you encounter issues, crashes, or glitches while using the Niri compositor, use these commands to check the logs:

* **View live logs in real-time:**
  ```bash
  journalctl --user -f -u niri
  ```
* **View logs from the current boot only:**
  ```bash
  journalctl --user -b -u niri
  ```
* **View the most recent errors (priority level Warning and above):**
  ```bash
  journalctl --user -u niri -p 3..4 --no-pager
  ```
* **Export logs to a file for debugging or sharing:**
  ```bash
  journalctl --user -u niri > niri-debug.log
  ```

---

## 👤 Author

* **GitHub:** [@minhz721](https://github.com)

Feel free to fork this repository or borrow snippets for your own NixOS journey!
