{ config, pkgs, ...}:

{
    services.xserver.windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages: with python3Packages; [
            qtile-extras
        ];
    };


    environment.systemPackages = with pkgs; [
        gsimplecal
        rofi
        picom
        dunst
        feh
        xfce4-screensaver
        xautolock
    ];
}