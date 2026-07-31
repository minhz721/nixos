{ config, pkgs, ... }:

{
  # Enable Niri Wayland compositor
  programs.niri.enable = true;

  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };

  # Configure Greetd display manager to log straight into Niri session
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "leomin"; # System user profile matching your setup
      };
    };
  };

  # Prevent Systemd from overriding the user-manager PATH variables
  systemd.user.services.niri.enableDefaultPath = false;

  # Essential security policies and authentication agents
  security.polkit.enable = true;

  # GNOME keyring (password storage)
  services.gnome.gnome-keyring.enable = true;

  # PAM for swaylock
  security.pam.services.swaylock = {};

  # Wayland support for Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    greetd.regreet
    # Niri dependencies
    xwayland-satellite

    # Wayland utilities
    swaylock
    swayidle
    swaybg
    mako

    # Apps
    fuzzel
    flameshot
  ];
}