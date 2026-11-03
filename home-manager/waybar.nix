{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 36;
      margin-top = 6;
      margin-left = 10;
      margin-right = 10;
      spacing = 8;
      modules-left = [
        "sway/workspaces"
        "sway/window"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "tray"
        "cpu"
        "temperature"
        "memory"
        "pulseaudio"
        "custom/wallpaper"
        "custom/powermenu"
      ];
      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = false;
        sort-by-number = true;
        format = "{name}";
      };
      "sway/window" = {
        format = "{}";
        max-length = 40;
        icon = true;
        icon-size = 16;
      };
      clock = {
        format = " {:%H:%M   %d/%m/%Y}";
        format-alt = " {:%H:%M:%S   %A, %d %B %Y}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };
      cpu = {
        format = "CPU: {usage}%";
        interval = 3;
      };
      memory = {
        format = "RAM: {used}GB";
        interval = 3;
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "🔇 Mute";
        format-icons = {
          default = [
            ""
            ""
            ""
          ];
        };
        on-click = "pavucontrol";
        on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
      tray = {
        icon-size = 18;
        spacing = 10;
      };
      "custom/powermenu" = {
        format = "";
        tooltip = false;
        on-click = "$HOME/.config/fuzzel/scripts/powermenu.sh";
      };
      "custom/wallpaper" = {
        format = "";
        tooltip = true;
        tooltip-format = "Toggle Wallpaper Panel";
        on-click = "$HOME/.config/fuzzel/scripts/wallpaper-select.sh";
      };
      temperature = {
        hwmon-path-abs = "/sys/class/hwmon";
        input-filename = "temp1_input";
        ritical-threshold = 80;
        format-critical = "🔥 {temperatureC}°C";
        format = " {temperatureC}°C";
        interval = 2;
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Maple Mono", "Inter", sans-serif;
        font-weight: bold;
        font-size: 15px;
        min-height: 0;
      }

      window#waybar {
        background-color: transparent;
        color: #cdd6f4;
      }

      #workspaces,
      #window,
      #clock,
      #pulseaudio,
      #cpu,
      #memory,
      #temperature,
      #tray {
        background-color: #1e1e2e;
        padding: 4px 12px;
        border-radius: 12px;
        border: 1px solid #313244;
      }

      #workspaces button {
        padding: 0 5px;
        color: #6c7086;
        background: transparent;
      }

      #workspaces button.active,
      #workspaces button.focused {
        color: #cba6f7;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background: transparent;
      }

      #window {
        color: #bac2de;
      }

      #clock {
        color: #89b4fa;
      }

      #pulseaudio {
        color: #f9e2af;
      }

      #cpu {
        color: #a6e3a1;
      }

      #memory {
        color: #94e2d5;
      }

      #tray {
        color: #cdd6f4;
      }

      #tray > .passive {
        opacity: 0.6;
      }

      #tray > .needs-attention {
        color: #f38ba8;
      }

      #tray menu {
        background: #1e1e2e;
        color: #cdd6f4;
        border-radius: 8px;
        padding: 8px;
      }

      #custom-powermenu {
        color: #f38ba8;
        background-color: #1e1e2e;
        border-radius: 12px;
        border: 1px solid #313244;
        padding: 4px 16px 4px 12px;
      }

      #custom-wallpaper {
        background-color: #1e1e2e;
        border-radius: 12px;
        border: 1px solid #313244;
        padding: 4px 16px 4px 12px;
      }

      #clock:hover,
      #pulseaudio:hover,
      #cpu:hover,
      #memory:hover,
      #battery:hover,
      #tray:hover,
      #temperature:hover,
      #custom-wallpaper:hover,
      #custom-powermenu:hover {
        background-color: #313244;
      }
    '';
  };
}
