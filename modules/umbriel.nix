{ inputs, ... }:

{
  imports = [
    inputs.umbriel.nixosModules.default
  ];

  programs.umbriel.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_QPA_PLATFORM = "wayland;xcb";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
