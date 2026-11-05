{pkgs, ...}: {
  home.packages = with pkgs; [
    # Shell & CLI Utilities
    fastfetch
    btop
    # Archive & System Utilities
    unzip
    unrar
    p7zip
    file-roller
    ffmpegthumbnailer
    poppler
    libgsf
    czkawka
    # File Managers
    yazi
    nemo-with-extensions
    nemo-fileroller
    # Multimedia
    imv
    mpv
    ffmpeg
    cava
    # Disk / Filesystem GUI & Automount
    gnome-disk-utility
    udiskie
    # System Themes / Icons
    gnome-themes-extra
    adwaita-icon-theme
    # Desktop Applications
    zathura
    mission-center
    localsend
    # Communication & Web Browsers
    discord
    telegram-desktop
    brave
    google-chrome
    # Development Applications & CLI
    bruno
    lazydocker
    lazygit
    lazysql

    # Runtimes & Toolchains
    uv
    bun
    # --- Rust Toolchain ---
    rustc
    cargo
    rust-analyzer
    # --- Nix Ecosystem ---
    nil
    alejandra
    statix
    deadnix
    # --- Web & Scripting ---
    vtsls
    vscode-langservers-extracted
    emmet-language-server
    prettier
    # --- Python & Shell ---
    ruff
    bash-language-server
    shellcheck
    shfmt
    # --- Build Tools ---
    gnumake
    # Formats (TOML & YAML & KDL)
    kdlfmt
    taplo
  ];
}
