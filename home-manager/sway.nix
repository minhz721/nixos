{
  pkgs,
  lib,
  config,
  ...
}:
let
  mod = "Mod4";
in
{
  home.packages = with pkgs; [
    swaybg
    grim
    slurp
    wl-clipboard
    zenity
  ];

  services.mako = {
    enable = true;
    settings = {
      font = "Maple Mono NF 11";
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      border-color = "#cba6f7";
      progress-color = "over #313244";
    };
    extraConfig = ''
      [urgency=low]
      border-color=#a6adc8

      [urgency=normal]
      border-color=#cba6f7

      [urgency=high]
      border-color=#fab387
      text-color=#f38ba8
    '';
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
          font_family = "Maple Mono NF";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    checkConfig = false;

    extraConfig = ''
      exec --no-startup-id swaymsg workspace 1
      client.focused          #f9e2af   #f9e2af   #1e1e2e   #f9e2af     #f9e2af
      client.focused_inactive #313244   #313244   #cdd6f4   #313244     #313244
      client.unfocused        #1e1e2e   #1e1e2e   #cdd6f4   #1e1e2e     #1e1e2e

      # SwayFX
      corner_radius 8
      animation_duration_ms 250
      default_dim_inactive 0.0
      blur disable
      shadows disable
    '';

    config = {
      modifier = mod;
      terminal = "ghostty";
      menu = "fuzzel";

      input = {
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "40";
        };
        "type:pointer" = {
          accel_profile = "flat";
        };
      };

      output = {
        "DP-1" = {
          mode = "2560x1440@200Hz";
          pos = "0 0";
        };
        "HDMI-A-1" = {
          mode = "1920x1080@60Hz";
          pos = "320 1440";
        };
      };

      startup = [
        {
          command = "sh -c 'pkill -x swaybg || true; [ -s ~/.cache/wallpaper_current ] && swaybg -i \"$(cat ~/.cache/wallpaper_current)\" -m fill'";
          always = true;
        }
        { command = "fcitx5 -d"; }
        { command = "blueman-applet"; }
      ];

      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];

      # bars = [
      #   {
      #     command = "/run/current-system/sw/bin/swaybar";
      #     statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${config.xdg.configHome}/i3status-rust/config-default.toml";
      #     position = "top";
      #     workspaceButtons = true;
      #     trayOutput = "none";
      #     fonts = {
      #       names = [
      #         "Maple Mono NF"
      #       ];
      #       size = 12.0;
      #     };
      #     colors = {
      #       statusline = "#cdd6f4";
      #       background = "#1e1e2e";
      #       inactiveWorkspace = {
      #         border = "#1e1e2e";
      #         background = "#1e1e2e";
      #         text = "#6c7086";
      #       };
      #       focusedWorkspace = {
      #         border = "#89b4fa";
      #         background = "#89b4fa";
      #         text = "#1e1e2e";
      #       };
      #       activeWorkspace = {
      #         border = "#313244";
      #         background = "#313244";
      #         text = "#cdd6f4";
      #       };
      #     };
      #   }
      # ];

      window = {
        border = 2;
        titlebar = false;
        commands =
          map
            (criteria: {
              command = "floating enable, move position center";
              inherit criteria;
            })
            [
              { app_id = "^(mpv|imv|cava|\\.blueman-manager-wrapped|blueman-manager|org\\.fcitx\\..*)$"; }
              { title = "(?i)Mission Center"; }
            ];
      };

      floating = {
        border = 5;
        titlebar = false;
      };

      gaps = {
        inner = 6;
        outer = 4;
      };

      keybindings = lib.mkOptionDefault {
        # Core
        "${mod}+q" = "kill";
        "${mod}+Shift+r" = "reload";
        "${mod}+l" = "exec hyprlock";

        # Screenshot
        "${mod}+Shift+s" =
          "exec sh -c 'mkdir -p ~/Pictures/Screenshots && geom=$(slurp) && grim -g \"$geom\" - | tee ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy'";
        "${mod}+p" =
          "exec sh -c 'mkdir -p ~/Pictures/Screenshots && out=$(swaymsg -t get_outputs | ${pkgs.jq}/bin/jq -r \".[] | select(.focused) | .name\") && grim -o \"$out\" - | tee ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy'";

        # Apps
        "${mod}+e" = "exec nemo";
        "${mod}+b" = "exec thorium";
        "${mod}+c" = "exec subl";

        # Layout
        "${mod}+f" = "fullscreen toggle";
        "${mod}+Shift+f" = "floating toggle";
        "${mod}+t" = "layout toggle split";
        "${mod}+Shift+b" = "splith";

        # Resize
        "${mod}+Ctrl+Left" = "resize shrink width 20 px";
        "${mod}+Ctrl+Down" = "resize grow height 20 px";
        "${mod}+Ctrl+Up" = "resize shrink height 20 px";
        "${mod}+Ctrl+Right" = "resize grow width 20 px";

        # Media keys
        "--locked XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
        "--locked XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
        "--locked XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "--locked XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };
    };
  };
}
