# ❄️ My NixOS Configuration

Welcome to my personal **NixOS** configuration repository. This setup manages my entire operating system, desktop environment, and user dotfiles in a fully declarative and reproducible way using **Nix Flakes**, **Home Manager**, and **SwayFX**.

## ✨ Features

- **Nix Flakes (26.05 & Unstable)**: Reproducible dependency management with locked package versions (`flake.lock`) alongside bleeding-edge packages via `nixpkgs-unstable` and custom inputs (`fenix`, `thorium`, `nixCats`, `nixvim`).
- **Home Manager**: Declarative user environments including terminals (`alacritty`, `ghostty`), editors (`neovim` via nixCats/nixvim, `zed`), multiplexer (`tmux`), shell (`fish`), and file manager (`nemo`).
- **SwayFX Window Manager**: Wayland tiling window management with smooth animations and rounded corners, paired with **ReGreet** (Noctalia-inspired dark theme), `waybar`, custom `fuzzel` scripts (`powermenu.sh`, `wallpaper-select.sh`), `mako`, and `hyprlock`.
- **NH (Nix Helper)**: Streamlined system rebuilds and automated garbage collection (`--keep-since 4d --keep 3`).
- **Vietnamese Input**: Pre-configured `fcitx5` with `fcitx5-lotus` for seamless Vietnamese typing on Wayland.
- **Development & Virtualization**: Ready-to-use `Rust` (via Fenix), `Docker` (on-demand socket activation), and `Virt-Manager` (QEMU/KVM + SPICE) setups.

## 📂 Repository Layout

```text
.
├── configuration.nix          # Core system-level entry point
├── docker-compose.yml         # Local container services configuration
├── flake.nix                  # Main entry point defining inputs and outputs
├── flake.lock                 # Strict version lockfile for reproducible builds
├── hardware-configuration.nix # Machine-specific hardware configuration
├── home-manager/              # User-level configurations and dotfiles
│   ├── default.nix            # Home Manager module aggregator
│   ├── desktop.nix            # Nemo, MIME defaults & GUI/multimedia applications
│   ├── dev.nix                # Rust toolchain (Fenix), LSPs, formatters & CLI dev tools
│   ├── shell.nix              # Fish shell, Starship prompt, Eza & Git configuration
│   ├── tmux.nix               # Tmux multiplexer with Catppuccin theme & Alt-key bindings
│   ├── sway.nix               # SwayFX keybindings, outputs, Mako & Hyprlock
│   ├── waybar.nix             # Status bar configuration
│   ├── fuzzel/                # Application launcher config & custom Wayland scripts
│   │   ├── default.nix
│   │   └── scripts/
│   │       ├── powermenu.sh
│   │       └── wallpaper-select.sh
│   ├── alacritty.nix          # Terminal emulators (Alacritty, Ghostty)
│   ├── ghostty.nix
│   ├── gtk.nix                # GTK, Qt, cursor & font theming
│   ├── thorium.nix            # Thorium browser with Wayland & VAAPI flags
│   ├── zed.nix                # Zed code editor configuration
│   ├── nixcats/               # Neovim configuration via nixCats (Lua-based)
│   │   ├── default.nix
│   │   ├── init.lua
│   │   └── lua/
│   └── nixvim/                # Neovim configuration via Nixvim (Nix-based)
│       ├── default.nix
│       └── ...
├── modules/                   # Modular system-level configurations
│   ├── default.nix            # System module aggregator
│   ├── core.nix               # Bootloader, timezone, locales, user & NH setup
│   ├── hardware.nix           # AMD GPU, PipeWire audio, Bluetooth, network & Udisks2
│   ├── desktop.nix            # SwayFX, ReGreet, Fcitx5-Lotus & system fonts
│   ├── packages.nix           # Nix Flakes settings, nix-ld & system packages
│   └── virtualization.nix     # Docker (socket-activated) & Virt-Manager (QEMU/KVM)
├── README.md                  # Repository documentation
└── virt-manager.md            # Virtualization setup notes & guide
```

## 🚀 Installation & Deployment

> ⚠️ **Warning:** Do not apply this configuration directly without updating `hardware-configuration.nix` to match your own machine's hardware, or your system may fail to boot.

### 1. Clone the repository

```bash
git clone https://github.com ~/nixos
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

### SwayFX Window Inspection

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

- **GitHub:** [@minhz721](https://github.com)

Feel free to fork this repository or borrow snippets for your own NixOS journey!

