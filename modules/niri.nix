{ config, pkgs, ... }:

{
  # Enable Niri Wayland compositor
  programs.niri.enable = true;

  boot.loader.grub.configurationLimit = 7;

  # PAM for swaylock
  security.pam.services.swaylock = {};

  # Wayland support for Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    # greetd.regreet
    regreet
    # Niri dependencies
    xwayland-satellite

    # Wayland utilities
    swaylock
    swayidle
    swaybg
    mako
    libnotify

    # Apps
    fuzzel
    grim
    wl-clipboard
  ];
}