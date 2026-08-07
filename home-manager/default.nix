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
    ./flameshot.nix
    ./librewolf.nix

    # niri
    # ./niri
    # ./fuzzel
    # ./waybar
    # ./mako.nix

    # qtile
    ./qtile
    ./rofi
    ./dunst
    ./picom.nix

    # nixvim
    ./nixvim
    ./tmux/tmux.nix
  ];

  home.username = "leomin";
  home.homeDirectory = "/home/leomin";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    fastfetch
    zoxide
    eza
    fish
    xclip

    #
    discord
    telegram-desktop
    brave
    zathura
    mpv
    cava
    imv
    mission-center
    dbeaver-bin
    localsend

    #
    lazydocker
    lazygit
    lazysql
  ];

  programs.home-manager.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";
}
