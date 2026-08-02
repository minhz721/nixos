{ config, pkgs, ... }:

{
  # Recursively link the entire directory layout into the XDG configuration path (~/.config/niri)
  xdg.configFile."qtile" = {
    source = ./.;
    recursive = true;
    executable = true; 
  };

  services.polkit-gnome.enable = true; # polkit
  
}
