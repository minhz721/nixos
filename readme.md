# ❄️ My NixOS Configuration

Welcome to my personal **NixOS** configuration repository. This setup manages my entire operating system, desktop environment, and user dotfiles in a fully declarative and reproducible way using **Nix Flakes**, **Home Manager**, and **Sway**.

## ✨ Features

- **Nix Flakes (26.05 & Unstable)**: Reproducible dependency management with locked package versions (`flake.lock`) alongside bleeding-edge packages via `nixpkgs-unstable` and custom inputs (`fenix`, `thorium`).
- **Home Manager**: Declarative user environments including terminals (`alacritty`, `ghostty`), editors (`zed`, `helix`), multiplexers (`zellij`, `tmux`), shell (`fish`), and file managers (`yazi`, `nemo`).
- **Sway Window Manager**: Wayland tiling window management paired with **Noctalia Greeter** (Catppuccin theme), `waybar`, custom `fuzzel` scripts (powermenu, window switcher, wallpaper selector), `mako`, and `hyprlock`.
- **NH (Nix Helper)**: Streamlined system rebuilds and automated garbage collection (`--keep-since 4d --keep 3`).
- **Vietnamese Input**: Pre-configured `fcitx5` with `fcitx5-lotus` for seamless Vietnamese typing on Wayland.
- **Development & Virtualization**: Ready-to-use `Rust` (via Fenix), `Docker`, and `Virt-Manager` (QEMU/KVM + SPICE) setups.

## 📂 Repository Layout

```text
.
├── configuration.nix          # Core system-level entry point
├── docker-compose.yml         # Local container services configuration
├── flake.nix                  # Main entry point defining inputs and outputs
├── flake.lock                 # Strict version lockfile for reproducible builds
├── hardware-configuration.nix # Machine-specific hardware configuration
├── home-manager/              # User-level configurations and dotfiles
│   ├── fuzzel/                # Application launcher config & custom Wayland scripts
│   ├── alacritty.nix          # Terminal configurations (Alacritty, Ghostty)
│   ├── ghostty.nix
│   ├── helix.nix              # Code editors (Helix, Zed)
│   ├── zed.nix
│   ├── rust.nix               # Rust toolchain via Fenix
│   ├── sway.nix               # Sway keybindings, outputs, and startup rules
│   ├── waybar.nix             # Status bar configuration
│   ├── yazi.nix               # Terminal & GUI file managers (Yazi, Nemo)
│   ├── nemo.nix
│   ├── zellj.nix              # Terminal multiplexers (Zellij, Tmux) & Shell (Fish)
│   ├── tmux.nix
│   ├── fish.nix
│   ├── stable.nix             # Nixpkgs stable user packages
│   └── unstale.nix            # Nixpkgs unstable user packages
├── modules/                   # Modular system-level configurations
│   ├── audio.nix              # PipeWire & rtkit audio setup
│   ├── bluetooth.nix          # Bluetooth & Blueman configuration
│   ├── bootloader.nix         # systemd-boot setup
│   ├── docker.nix             # Docker daemon & compose
│   ├── fcitx5.nix             # Vietnamese input method (fcitx5-lotus)
│   ├── fonts.nix              # Nerd Fonts & Maple Mono NF
│   ├── locales.nix            # Timezone (Asia/Ho_Chi_Minh) & locale settings
│   ├── network.nix            # NetworkManager & firewall rules (LocalSend)
│   ├── nh.nix                 # Nix Helper & automated GC
│   ├── packages.nix           # System packages & Nix settings
│   ├── service.nix            # AMD GPU, Polkit, Udisks2 & Logind tweaks
│   ├── sway.nix               # Sway & Noctalia Greeter system integration
│   ├── user.nix               # User account & default Fish shell
│   └── virt-manager.nix       # QEMU/KVM & Libvirtd virtualization
├── readme.md                  # Repository documentation
└── virt-manager.md            # Virtualization setup notes & guide
```

## 🚀 Installation & Deployment

> ⚠️ **Warning:** Do not apply this configuration directly without updating `hardware-configuration.nix` to match your own machine's hardware, or your system may fail to boot.

### 1. Clone the repository

```bash
git clone https://github.com/minhz721/nixos ~/nixos
cd ~/nixos
```

### 2. Generate your hardware configuration (For new machines)

Overwrite the repository's hardware file with your local hardware setup:

```bash
sudo cp /etc/nixos/hardware-configuration.nix .
```

### 3. Apply the configuration

Rebuild and switch to the system configuration using `nh` (recommended) or standard `nixos-rebuild`:

```bash
# Using nh (Nix Helper)
nh os switch

# Or using standard nixos-rebuild
sudo nixos-rebuild switch --flake .#leomin
```

## 🛠️ Useful Commands

- **Update all flake inputs:**
  ```bash
  nix flake update
  ```
- **Rebuild and switch using NH:**
  ```bash
  nh os switch
  ```
- **Clean up old generations manually:**
  ```bash
  nh clean all --keep 3
  ```
- **Optimize the Nix store:**
  ```bash
  nix-store --optimise
  ```

## 🔍 Troubleshooting & Utilities

### Sway Window Inspection

Get `app_id` or window `name` for configuring floating rules:

```bash
swaymsg -t get_tree | grep -E '"app_id"|"name"'
```

For XWayland applications:

```bash
xprop WM_CLASS
```

### Creating a Bootable USB with Ventoy

Run Ventoy temporarily without installing it permanently:

```bash
NIXPKGS_ALLOW_UNFREE=1 nix shell nixpkgs#ventoy --impure
```

Check your target drive using `lsblk`, then install:

```bash
sudo ventoy -i /dev/sdX
```

## 👤 Author

- **GitHub:** [@minhz721](https://github.com/minhz721)

Feel free to fork this repository or borrow snippets for your own NixOS journey!
