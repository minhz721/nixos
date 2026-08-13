{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    libnotify
    wl-clipboard
    swaybg
    nwg-displays
    wlr-randr
    grim
    slurp
    jq
  ];

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      font = "monospace 10";
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
        timeout = 300;
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
          font_family = "FiraCode Nerd Font Bold";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  wayland.windowManager.sway = {
    extraConfig = ''
      include ~/.config/sway/outputs
    '';
    enable = true;
    config = {
      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "DP-1";
        }
        {
          workspace = "3";
          output = "DP-1";
        }
        {
          workspace = "5";
          output = "DP-1";
        }
        {
          workspace = "7";
          output = "DP-1";
        }
        {
          workspace = "9";
          output = "DP-1";
        }

        {
          workspace = "2";
          output = "HDMI-A-1";
        }
        {
          workspace = "4";
          output = "HDMI-A-1";
        }
        {
          workspace = "6";
          output = "HDMI-A-1";
        }
        {
          workspace = "8";
          output = "HDMI-A-1";
        }
      ];
      modifier = "Mod4";
      terminal = "ghostty";
      menu = "fuzzel";
      startup = [
        {command = "sh -c 'swaybg -i $(cat ~/.cache/wallpaper_current) -m fill'";}
        {command = "waybar";}
        {command = "fcitx5 -d";}
        {command = "mako";}
        {command = "blueman-applet";}
        # {command = "ab-download-manager";}
        {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
      ];
      bars = [];
      window = {
        border = 5;
        titlebar = false;
      };
      floating = {
        border = 5;
        titlebar = false;
      };
      gaps = {
        inner = 6;
        outer = 4;
      };
      window.commands = [
        {
          command = "floating enable, move center";
          criteria.app_id = "blueman-manager";
        }
        {
          command = "floating enable, move center";
          criteria.app_id = "blueman-manager-wrapped";
        }
        {
          command = "floating enable, move center";
          criteria.app_id = "mpv";
        }
        {
          command = "floating enable, move center";
          criteria.app_id = "imv";
        }
        {
          command = "floating enable, move center";
          criteria.app_id = "cava";
        }
        {
          command = "floating enable, move center";
          criteria.app_id = "fcitx5-configtool";
        }
        {
          command = "floating enable, move center";
          criteria = {
            class = "com-abdownloadmanager-desktop-AppKt";
          };
        }
        {
          command = "floating enable, move center";
          criteria.title = "(?i)(Mission Center)";
        }
      ];
      keybindings = let
        modifier = "Mod4";
      in
        pkgs.lib.mkOptionDefault {
          # Core shortcuts
          "${modifier}+Return" = "exec ghostty";
          "${modifier}+d" = "exec fuzzel";
          "${modifier}+q" = "kill";
          "${modifier}+Shift+r" = "reload";
          "${modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy";
          "${modifier}+l" = "exec hyprlock";
          "${modifier}+Tab" = "exec ${config.home.homeDirectory}/.config/fuzzel/scripts/sway-window-switcher.sh";       

          # Application shortcuts
          "${modifier}+e" = "exec nemo";
          "${modifier}+b" = "exec thorium";
          "${modifier}+c" = "exec code";

          # Window layout controls
          "${modifier}+f" = "floating toggle";
          "${modifier}+Shift+f" = "focus mode_toggle";

          # "${modifier}+r" = "mode resize";
          "${modifier}+Ctrl+h" = "resize shrink width 20 px";
          "${modifier}+Ctrl+j" = "resize grow height 20 px";
          "${modifier}+Ctrl+k" = "resize shrink height 20 px";
          "${modifier}+Ctrl+l" = "resize grow width 20 px";

          # Direct window resizing using arrow keys
          "${modifier}+Ctrl+Left" = "resize shrink width 20 px";
          "${modifier}+Ctrl+Down" = "resize grow height 20 px";
          "${modifier}+Ctrl+Up" = "resize shrink height 20 px";
          "${modifier}+Ctrl+Right" = "resize grow width 20 px";

          # Switch to workspace
          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";

          # Move focused container to workspace
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";

          # Move focused window (Vim keys)
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          # Move focused window (Arrow keys)
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          # Layout
          "${modifier}+v" = "splitv";
          "${modifier}+Shift+b" = "splith";

          # Hardware Media keys (Migrated from your Qtile config with limit 1.0)
          "--locked XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
          "--locked XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
          "--locked XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "--locked XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        };
    };
  };
}
