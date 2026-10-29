{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./ghostty.nix
    ./fish.nix
    ./git.nix
    ./nemo
    ./gtk.nix
    ./librewolf.nix
    ./yazi.nix
    ./fcitx5.nix
    ./helix.nix

    ./rofi
    ./dunst
    ./picom.nix
    ./flameshot.nix
    ./i3.nix

    # sway
    # ./sway.nix
    # ./fuzzel
    # ./waybar

    # nixvim
    ./nixvim
    ./tmux/tmux.nix
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.username = "leomin";
  home.homeDirectory = "/home/leomin";

  home.packages = with pkgs; [
    # =========================================================================
    # Shell & CLI Utilities / Search Tools
    # =========================================================================
    fastfetch
    zoxide
    eza
    ripgrep
    fzf
    fd

    # =========================================================================
    # Runtimes & Development Toolchains
    # =========================================================================
    uv   # Python
    ruff
    bun  # JavaScript / TypeScript

    # Rust toolchain & ecosystem
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    cargo-watch
    cargo-nextest

    # Compilers & Build Tools
    gnumake

    # =========================================================================
    # Language Servers (LSPs) & Code Quality (Format / Lint)
    # =========================================================================
    # LSP Binaries & Tools
    nil
    vtsls
    pyright
    marksman    # Markdown LSP
    bash-language-server
    vscode-langservers-extracted
    yaml-language-server
    svelte-language-server

    # Linters & Formatters
    prettier
    shellcheck
    shfmt
    hadolint
    alejandra
    statix
    deadnix
    stylua
    sqlfluff

    # =========================================================================
    # Archive & System Utilities
    # =========================================================================
    unzip
    unrar
    p7zip
    file-roller
    ffmpegthumbnailer
    poppler
    libgsf
    openjdk
    czkawka # finder duplicate

    # =========================================================================
    # File Manager & Desktop Applications
    # =========================================================================
    yazi
    nemo-with-extensions
    nemo-fileroller
    zathura
    imv
    mpv
    ffmpeg
    cava
    mission-center
    localsend

    # =========================================================================
    # Communication & Web
    # =========================================================================
    discord
    telegram-desktop
    brave

    # =========================================================================
    # Development & Database Clients
    # =========================================================================
    vscode
    bruno
    lazydocker
    lazygit
    lazysql
    # dbeaver-bin
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}