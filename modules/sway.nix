{inputs, ...}: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  # Noctalia Greeter
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      appearance.scheme = "Catppuccin";
      keyboard.layout = "us";
      output.name = "DP-1";
      session.default = "sway";
      user.default = "leomin";
    };
  };

  # Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = [];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_QPA_PLATFORM = "wayland;xcb";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
