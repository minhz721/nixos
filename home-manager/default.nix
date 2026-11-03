{
  imports = [
    ./ghostty.nix
    ./fish.nix
    ./git.nix
    ./nemo
    ./gtk.nix
    ./librewolf.nix
    ./yazi.nix
    ./helix.nix
    ./gram.nix
    ./tmux/tmux.nix
    ./stable.nix
    ./unstale.nix

    # ./rofi
    # ./dunst
    # ./picom.nix
    # ./flameshot.nix
    # ./i3.nix

    ./swayfx.nix
    ./fuzzel
    ./waybar.nix
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.username = "leomin";
  home.homeDirectory = "/home/leomin";
  programs.home-manager.enable = true;
  home.stateVersion = "26.05";
}
