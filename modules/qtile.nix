{
  config,
  pkgs,
  ...
}: {
  services.xserver.windowManager.qtile = {
    enable = true;
    extraPackages = python3Packages:
      with python3Packages; [
        qtile-extras
      ];
  };

  environment.systemPackages = with pkgs; [
    gsimplecal
    rofi
    picom
    dunst
    feh
    lightlocker
    xclip
  ];

  # services.xserver.displayManager.sessionCommands = ''
  #   ${pkgs.xrandr}/bin/xrandr \
  #       --output DisplayPort-0 --mode 2560x1440 --rate 200 --primary --pos 0x0 \
  #       --output HDMI-A-0 --mode 1920x1080 --rate 60 --pos 320x1440
  # '';
}
