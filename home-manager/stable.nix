{pkgs, ...}: {
  home.packages = with pkgs; [
    # Shell & CLI Utilities
    fastfetch
    # Archive & System Utilities
    unzip
    unrar
    p7zip
    file-roller
    ffmpegthumbnailer
    poppler
    libgsf
    openjdk
    czkawka # Duplicate finder
    # File Managers
    yazi
    nemo-with-extensions
    nemo-fileroller
    # Multimedia
    imv
    mpv
    ffmpeg
    cava
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

    # Rust toolchain
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    cargo-watch
    cargo-nextest

    # Build tools
    gnumake

    # Language Servers (LSP)
    nixd
    vtsls
    emmet-language-server
    bash-language-server
    vscode-langservers-extracted
    yaml-language-server
    dockerfile-language-server
    marksman
    sqls

    # Formatters
    alejandra
    prettier
    shfmt
    kdlfmt
    ruff

    # Linters & Static Analysis
    shellcheck
    hadolint
    statix
    deadnix
    sqlfluff
  ];
}
