{ config, pkgs, ... }:

{
  # Recursively link the entire directory layout into the XDG configuration path (~/.config/niri)
  xdg.configFile."qtile" = {
    source = ./.;
    recursive = true;
    executable = true; 
  };

  services.polkit-gnome.enable = true; # polkit

  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = "${pkgs.lightlocker}/bin/light-locker-command --lock";
  };

}
