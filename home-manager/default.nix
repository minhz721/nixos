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
    # Shell & CLI Utilities
    # =========================================================================
    fastfetch

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
    google-chrome

    # Development applications / CLI tools
    vscode
    bruno
    lazydocker
    lazygit
    lazysql
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
