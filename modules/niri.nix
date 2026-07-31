{ config, pkgs, ... }:

{
  # Enable Niri Wayland compositor
  programs.niri.enable = true;

  # Security / authentication
  security.polkit.enable = true;

  # GNOME keyring (password storage)
  services.gnome.gnome-keyring.enable = true;

  # PAM for swaylock
  security.pam.services.swaylock = {};

  # Wayland support for Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    regreet
    # Niri dependencies
    xwayland-satellite

    # Wayland utilities
    swaylock
    swayidle
    swaybg
    mako

    # Apps
    fuzzel
    grim
    flameshot
    wl-clipboard
  ];
}