{ user, ... }:

{
  imports = [
    ./shell.nix
    ./dev.nix
    ./apps.nix
    ./nemo.nix
    ./gtk.nix
    ./thorium.nix
    ./ghostty.nix
    ./nixcats
    ./fuzzel
    ./sway.nix
    ./waybar.nix
    ./sublime-text.nix
    # ./swaybar.nix
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";
  programs.home-manager.enable = true;
  home.stateVersion = "26.05";
}
