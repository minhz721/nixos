{pkgs, ...}: {
  home.packages = with pkgs; [
    # Archive & System Utilities
    czkawka
    # File Managers
    yazi
    # Multimedia
    imv
    mpv
    ffmpeg
    cava
    # Disk / Filesystem GUI & Automount
    gnome-disk-utility
    # Desktop Applications
    zathura
    mission-center
    localsend
    # Communication & Web Browsers
    telegram-desktop

    # CLI tools
    fzf
    fd
    ripgrep
    zoxide
    curl
    jq
    yq
    bat

    # Development Applications & CLI
    bruno
    lazydocker
    lazygit
    lazysql

    # Runtimes & Toolchains
    uv
    bun
    nodejs
    # --- Nix Ecosystem ---
    nixd
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
