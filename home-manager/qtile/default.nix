{
  config,
  pkgs,
  ...
}: {
  # Recursively link the entire directory layout into the XDG configuration path (~/.config/niri)
  xdg.configFile."qtile" = {
    source = ./.;
    recursive = true;
    executable = true;
  };

  services.screen-locker = {
    enable = true;
    inactiveInterval = 20;
    lockCmd = "${pkgs.lightlocker}/bin/light-locker-command --lock";
  };
}
