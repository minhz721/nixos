{
  pkgs,
  pkgsUnstable,
  inputs,
  user,
  ...
}:

{
  # Fonts
  fonts = {
    packages = with pkgs; [
      maple-mono.NF
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Maple Mono NF" ];
        sansSerif = [ "Maple Mono NF" ];
      };
    };
  };

  # Vietnamese Input Method (Fcitx5 + Lotus)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = [
        pkgsUnstable.fcitx5-lotus
        pkgs.fcitx5-gtk
      ];
      settings = {
        inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "lotus";
        };
        globalOptions = {
          "Hotkey/TriggerKeys"."0" = "Control+Shift_L";
          "Hotkey/AltTriggerKeys"."0" = "";
        };
      };
    };
  };

  # SwayFX & Wayland Session Variables
  programs.sway = {
    enable = true;
    package = pkgsUnstable.swayfx;
    wrapperFeatures.gtk = true;
    extraPackages = [ ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_QPA_PLATFORM = "wayland;xcb";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
  };

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
      user.default = user;
    };
  };
}
