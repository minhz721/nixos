{
  imports = [
    ./shell.nix
    ./dev.nix
    ./desktop.nix
    ./gtk.nix
    ./thorium.nix
    ./ghostty.nix
    ./nixcats
    ./fuzzel
    ./sway.nix
    ./waybar.nix
    # ./swaybar.nix
    ./zed.nix

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
