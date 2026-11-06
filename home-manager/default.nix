{
  imports = [
    ./ghostty.nix
    ./fish.nix
    ./git.nix
    ./nemo
    ./gtk.nix
    ./librewolf.nix
    ./yazi.nix
    ./gram.nix
    ./stable.nix
    ./unstale.nix
    # ./fresh/fresh.nix
    ./helix.nix
    ./mitos.nix
    ./zellj.nix

    # ./rofi
    # ./dunst
    # ./picom.nix
    # ./flameshot.nix
    # ./i3.nix

    ./sway.nix
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
