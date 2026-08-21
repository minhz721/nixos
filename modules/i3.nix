{
  config,
  pkgs,
  callPackage,
  ...
}: {
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
    };
    displayManager.lightdm = {
      enable = true;
    };
  };

  services.displayManager.defaultSession = "none+i3";

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xrandr}/bin/xrandr \
        --output DisplayPort-0 --mode 2560x1440 --rate 200 --primary --pos 0x0 \
        --output HDMI-A-0 --mode 1920x1080 --rate 60 --pos 320x1440
  '';

  environment.systemPackages = with pkgs; [
    rofi
    picom
    dunst
    feh
    lightlocker
    xclip
    font-awesome
    i3status-rust
    mesa-demos
  ];
}
