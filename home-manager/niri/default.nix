{ config, pkgs, ... }:

{
  # Recursively link the entire directory layout into the XDG configuration path (~/.config/niri)
  xdg.configFile."niri" = {
    source = ./.;
    recursive = true;
  };

  programs.alacritty.enable = true; # Super+T in the default setting (terminal)
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit
  
}
