{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];
  # Noctalia Greeter
  programs.noctalia-greeter = {
    enable = true;
    settings = {
      appearance = {
        scheme = "Catppuccin";
      };
      keyboard = {
        layout = "us";
      };
      output = {
        name = "DP-1";
      };
      session = {
        default = "niri";
      };
      user = {
        default = "leomin";
      };
    };
  };

  # Needed for user/session handling
  services.accounts-daemon.enable = true;

  programs.niri.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
    config.common.default = "*";
  };

  environment.systemPackages = with pkgs; [
    # Niri dependencies
    xwayland-satellite

    # Wayland utilities
    swayidle
    swaybg
    mako
    libnotify
    hyprlock

    # Apps
    fuzzel
    # clipboard
    wl-clipboard

    jq
    # nwg-displays
    wlr-randr
    grim
    slurp
    udiskie
  ];
}
