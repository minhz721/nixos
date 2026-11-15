{
  imports = [
    # ./ghostty.nix
    ./fish.nix
    ./git.nix
    ./nemo.nix
    ./gtk.nix
    ./yazi.nix
    ./stable.nix
    ./unstale.nix
    ./helix.nix
    ./zellj.nix
    ./tmux.nix
    ./rust.nix
    ./thorium.nix
    ./alacritty.nix
    ./zed.nix

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
