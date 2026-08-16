{
  config,
  pkgs,
  ...
}: {
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        savePath = "${config.home.homeDirectory}/Pictures/Screenshots";
        showStartupLaunchMessage = "false";
        disabledTrayIcon = "false";
        useGrimAdapter = "true";
        
        disabledGrimWarning = "true";
      };
    };
  };

  home.activation.createScreenshotDir = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${config.home.homeDirectory}/Pictures/Screenshots"
  '';
}
