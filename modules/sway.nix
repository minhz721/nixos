{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Enable core components
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      grim
      pulseaudio
      swayidle
      brightnessctl
    ];
  };
  programs.hyprlock.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "auto";
}
