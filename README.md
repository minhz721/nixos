# ❄️ My NixOS Configuration

Welcome to my personal **NixOS** configuration repository. This setup manages my entire operating system, desktop environment, and user dotfiles in a fully declarative and reproducible way using **Nix Flakes**, **Home Manager**, and **SwayFX**.

## ✨ Features

- **Nix Flakes (26.05 & Unstable)**: Reproducible dependency management with locked package versions (`flake.lock`) alongside bleeding-edge packages via `nixpkgs-unstable`, `nixCats`, and `noctalia-greeter`.
- **Single-Variable User & Host**: Parameterized `user` variable in `flake.nix` controlling system user, `hostname`, greeter defaults, and Home Manager paths from one place.
- **Home Manager**: Declarative user environments including terminals (`alacritty`, `ghostty`), editors (`neovim` via `nixCats`, `sublime-text`), multiplexer (`tmux`), shell (`fish`), and file manager (`nemo` with custom archive extraction).
- **SwayFX Window Manager**: Wayland tiling window management with smooth animations and rounded corners, paired with **Noctalia Greeter**, `waybar`, custom `fuzzel` scripts (`control-center.sh`, `wallpaper.sh`), `mako`, and `hyprlock`.
- **NH (Nix Helper)**: Streamlined system rebuilds and automated garbage collection (`--keep-since 4d --keep 3`).
- **Vietnamese Input**: Pre-configured `fcitx5` with `fcitx5-lotus` for seamless Vietnamese typing on Wayland.
- **Development & Virtualization**: Ready-to-use `Rust` toolchain (`symlinkJoin` from unstable), `Bun`, `Node.js`, `Python (uv/ruff)`, `Docker` (on-demand socket activation), and `Virt-Manager` (QEMU/KVM + SPICE) setups.

## 📂 Repository Layout

```text
.
├── configuration.nix          # Core system-level entry point
├── docs/
│   └── virt-manager.md        # Virtualization setup notes & guide
├── flake.nix                  # Main entry point defining inputs, user & outputs
├── flake.lock                 # Strict version lockfile for reproducible builds
├── hardware-configuration.nix # Machine-specific hardware configuration
├── home-manager/              # User-level configurations and dotfiles
│   ├── default.nix            # Home Manager module aggregator
│   ├── apps.nix               # GUI/multimedia applications, XDG userDirs & MIME defaults
│   ├── nemo.nix               # Nemo file manager settings, Ghostty action & extract script
│   ├── dev.nix                # Rust toolchain, LSPs, formatters, direnv & dev tools
│   ├── shell.nix              # Fish shell, Starship prompt, Atuin, Eza & Git configuration
│   ├── tmux.nix               # Tmux multiplexer configuration
│   ├── sway.nix               # SwayFX keybindings, outputs, Mako & Hyprlock
│   ├── swaybar.nix            # Alternative Swaybar configuration
│   ├── waybar.nix             # Status bar configuration
│   ├── fuzzel/                # Application launcher config & custom Wayland scripts
│   │   ├── default.nix
│   │   └── scripts/
│   │       ├── control-center.sh
│   │       └── wallpaper.sh
│   ├── alacritty.nix          # Alacritty terminal configuration
│   ├── ghostty.nix            # Ghostty terminal configuration
│   ├── gtk.nix                # GTK, Qt, cursor & font theming (adw-gtk3-dark + Maple Mono NF)
│   ├── thorium.nix            # Thorium browser with Wayland & VAAPI flags
│   ├── sublime-text.nix       # Sublime Text configuration
│   └── nixcats/               # Neovim configuration via nixCats (Lua-based)
│       ├── default.nix
│       ├── init.lua
│       └── lua/
├── modules/                   # Modular system-level configurations
│   ├── default.nix            # System module aggregator
│   ├── core.nix               # Bootloader, timezone, locales, user & NH setup
│   ├── hardware.nix           # AMD GPU, PipeWire audio, Bluetooth, network & Udisks2
│   ├── desktop.nix            # SwayFX, Noctalia Greeter, Fcitx5-Lotus & system fonts
│   ├── packages.nix           # Nix Flakes settings, nix-ld & system packages
│   └── virtualization.nix     # Docker (socket-activated) & Virt-Manager (QEMU/KVM)
├── packages/
│   └── thorium/
│       └── default.nix        # Custom Thorium browser package derivation
├── scripts/
│   └── update-thorium.sh      # Helper script to update Thorium version & hashes
└── README.md                  # Repository documentation
```

## 🚀 Installation & Deployment

> ⚠️ **Warning:** Do not apply this configuration directly without updating `hardware-configuration.nix` to match your own machine's hardware, or your system may fail to boot.

### 1. Clone the repository

```bash
git clone https://github.com ~/nixos
cd ~/nixos
```

### 2. Generate your hardware configuration & set username

Overwrite the repository's hardware file with your local hardware setup:

```bash
sudo cp /etc/nixos/hardware-configuration.nix .
```

*(Optional)* Change `user = "leomin";` in `flake.nix` if deploying for a different user/hostname.

### 3. Apply the configuration

Rebuild and switch to the system configuration using `nh` (recommended) or standard `nixos-rebuild`:

```bash
# Using nh (Nix Helper)
nh os switch

# Or using standard nixos-rebuild (replace <user> with the value set in flake.nix)
sudo nixos-rebuild switch --flake .#leomin
```

## 🛠️ Useful Commands

- **Update all flake inputs:**
  ```bash
  nix flake update
  ```
- **Update custom Thorium package:**
  ```bash
  ./scripts/update-thorium.sh
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

