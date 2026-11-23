{ config, ... }:
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
        "custom/control-center"
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
        tooltip = false;
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
      "custom/control-center" = {
        format = "";
        tooltip = true;
        tooltip-format = "Control Center";
        on-click = "$HOME/.config/fuzzel/scripts/control-center.sh";
      };
      temperature = {
        hwmon-path-abs = "/sys/class/hwmon";
        input-filename = "temp1_input";
        critical-threshold = 80;
        format-critical = "🔥 {temperatureC}°C";
        format = " {temperatureC}°C";
        interval = 2;
      };
    };

    style = ''
      @import url("${config.home.homeDirectory}/.cache/current-theme/waybar.css");

      * {
        border: none;
        border-radius: 0;
        font-family: "Maple Mono NF", "Inter", sans-serif;
        font-weight: bold;
        font-size: 15px;
        min-height: 0;
      }

      window#waybar {
        background-color: transparent;
        color: @fg;
      }

      #workspaces,
      #window,
      #clock,
      #pulseaudio,
      #cpu,
      #memory,
      #temperature,
      #tray,
      #custom-control-center {
        background-color: @bg;
        padding: 4px 12px;
        border-radius: 12px;
        border: 1px solid @surface;
      }

      #workspaces button {
        padding: 0 5px;
        color: @muted;
        background: transparent;
      }

      #workspaces button.active,
      #workspaces button.focused {
        color: @accent;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background: transparent;
      }

      #window { color: @subtext; }
      #clock { color: @blue; }
      #pulseaudio { color: @yellow; }
      #cpu { color: @green; }
      #memory { color: @teal; }
      #tray { color: @fg; }

      #tray > .passive { opacity: 0.6; }
      #tray > .needs-attention { color: @red; }
      #tray menu {
        background: @bg;
        color: @fg;
        border-radius: 8px;
        padding: 8px;
      }

      #custom-control-center {
        color: @accent;
        padding: 4px 15px 4px 12px;
      }

      #clock:hover,
      #pulseaudio:hover,
      #cpu:hover,
      #memory:hover,
      #tray:hover,
      #temperature:hover,
      #custom-control-center:hover {
        background-color: @surface;
      }

      tooltip {
        background-color: @bg;
        border: 1px solid @accent;
        border-radius: 10px;
      }

      tooltip label {
        color: @fg;
        padding: 4px 8px;
      }
    '';
  };
}
