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
        default = "sway";
      };
      user = {
        default = "leomin";
      };
    };
  };

  # Enable core components
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      grim
      swayidle
      brightnessctl
    ];
  };
  programs.hyprlock.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "auto";
}
