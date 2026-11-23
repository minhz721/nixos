{
  imports = [
    ./fish.nix
    ./git.nix
    ./gtk.nix
    ./yazi.nix
    ./stable.nix
    ./unstale.nix
    ./rust.nix
    ./thorium.nix
    ./ghostty.nix
    ./zed.nix
    ./nemo.nix
    ./mitos.nix
    ./sway.nix
    ./fuzzel
    ./waybar.nix
    ./nixcats
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
