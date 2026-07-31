{ config, pkgs, ... }:

{
  # Enable the Niri Wayland compositor at the system level
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
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = {};
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [ 
    xwayland-satellite # Protocol layer allowing older X11 apps to run on Wayland
    swaylock           # Security utility to screen-lock the user session
    mako               # Light-weight desktop notification daemon
    swayidle           # User idle tracking agent for power management hooks
    swaybg             # Wallpaper rendering engine targeted for Wayland
    fuzzel
    flameshot
  ];
}
