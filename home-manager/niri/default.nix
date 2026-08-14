{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."niri" = {
    source = ./.;
    recursive = true;
  };

  services.polkit-gnome.enable = true;

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      font = "JetBrainsMono Nerd Font";
      background-color = "#1e1e2eff";
      text-color = "#cdd6f4ff";
      border-color = "#cba6f7ff";
      border-size = 2;
      border-radius = 8;
      margin = "10,10";
      padding = "10";
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
      }
    ];
    events = {
      before-sleep = "${pkgs.hyprlock}/bin/hyprlock";
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 0;
        hide_cursor = true;
      };
      background = [
        {
          path = "/home/leomin/Pictures/wallpaper.jpg";
          blur_passes = 2;
          blur_size = 7;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
        }
      ];
      input-field = [
        {
          monitor = "DP-1";
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(203, 166, 247, 1.0)";
          inner_color = "rgba(30, 30, 46, 1.0)";
          font_color = "rgba(205, 214, 244, 1.0)";
          fade_on_empty = false;
          placeholder_text = "<i>Enter Password...</i>";
          hide_input = false;
          position = "0, -120";
          halign = "center";
          valign = "center";
        }
      ];
      label = [
        {
          text = "$TIME";
          color = "rgba(205, 214, 244, 1.0)";
          font_size = 120;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
