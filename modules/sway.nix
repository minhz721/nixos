{
  pkgs,
  pkgsUnstable,
  lib,
  ...
}:
let
  greeterSwayConfig = pkgs.writeText "greetd-sway-config" ''
    output DP-1 mode 2560x1440@200Hz pos 0 0
    output HDMI-A-1 disable

    bar {
      mode invisible
    }
    default_border none
    for_window [app_id="regreet"] fullscreen enable, focus

    exec "${lib.getExe pkgs.regreet}; swaymsg exit"
  '';
in
{
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
  };

  programs.regreet = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    font = {
      name = "Maple Mono NF";
      size = 14;
    };
    settings = {
      GTK = {
        application_prefer_dark_theme = true;
      };
    };

    extraCss = ''
      window {
        background-color: #0e0e12;
      }

      box.vertical {
        background-color: rgba(24, 24, 30, 0.92);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 20px;
        padding: 36px 42px;
        min-width: 360px;
        box-shadow: 0 12px 32px rgba(0, 0, 0, 0.6);
      }

      entry {
        background-color: #121217;
        color: #f4f4f6;
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 12px;
        padding: 11px 16px;
        margin-top: 8px;
        margin-bottom: 14px;
        caret-color: #ffffff;
      }

      entry:focus {
        border-color: rgba(255, 255, 255, 0.45);
        background-color: #16161d;
      }

      combobox button,
      dropdown button {
        background-color: #121217;
        color: #e4e4e7;
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 12px;
        padding: 9px 16px;
        margin-bottom: 10px;
      }

      combobox button:hover,
      dropdown button:hover {
        background-color: #1c1c24;
        border-color: rgba(255, 255, 255, 0.25);
      }

      button.suggested-action {
        background-color: #f4f4f6;
        color: #0e0e12;
        font-weight: bold;
        border-radius: 12px;
        padding: 11px 20px;
        margin-top: 8px;
      }

      button.suggested-action:hover {
        background-color: #ffffff;
      }
    '';
  };

  services.greetd.settings.default_session = {
    command = lib.mkForce "${pkgsUnstable.swayfx}/bin/sway --config ${greeterSwayConfig}";
    user = "greeter";
  };

}
