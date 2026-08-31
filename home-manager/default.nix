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

    # ./qtile
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

  home.username = "leomin";
  home.homeDirectory = "/home/leomin";

  home.packages = with pkgs; [
    # =========================================================================
    # Shell & CLI Utilities
    # =========================================================================
    fastfetch
    zoxide
    eza
    uv

    # =========================================================================
    # Archive / Java
    # =========================================================================
    unzip
    unrar
    p7zip
    file-roller
    ffmpegthumbnailer
    poppler
    libgsf
    openjdk

    # =========================================================================
    # File Manager
    # =========================================================================
    yazi
    nemo-with-extensions
    nemo-fileroller

    # =========================================================================
    # Media & Desktop Utilities
    # =========================================================================
    ffmpeg
    mpv
    cava
    imv
    zathura
    mission-center
    localsend

    # =========================================================================
    # Communication
    # =========================================================================
    discord
    telegram-desktop

    # =========================================================================
    # Web Browser
    # =========================================================================
    brave

    # =========================================================================
    # Development
    # =========================================================================
    vscode
    dbeaver-bin
    bruno
    lazydocker
    lazygit
    lazysql

    # =========================================================================
    # Finder
    # =========================================================================
    czkawka
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
