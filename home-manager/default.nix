{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./ghostty.nix
    ./shell.nix
    ./git.nix
    ./nemo
    ./gtk.nix
    ./librewolf.nix
    ./yazi.nix

    # niri
    # ./niri
    # ./fuzzel
    # ./waybar

    ./rofi
    ./qtile
    ./dunst
    ./picom.nix
    ./flameshot.nix


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

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # =========================================================================
    # Shell & CLI Utilities
    # =========================================================================
    fastfetch
    zoxide
    eza

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
    # Development Tools
    # =========================================================================
    dbeaver-bin
    bruno
    lazydocker
    lazygit
    lazysql
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
