{ ... }:

{
  services.flameshot = {
    enable = true;

    settings = {
      General = {
        savePath = "/home/leomin/Pictures/Screenshots";
        showStartupLaunchMessage = false;
        disabledTrayIcon = false;
      };
    };
  };
}