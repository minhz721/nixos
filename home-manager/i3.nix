{
  config,
  pkgs,
  ...
}: {
  services.screen-locker = {
    enable = true;
    inactiveInterval = 15;
    lockCmd = "${pkgs.lightlocker}/bin/light-locker-command --lock";
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "ghostty";
      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
          trayOutput = "primary";
          trayPadding = 4;
          fonts = {
            names = ["JetBrainsMono Nerd Font" "Font Awesome 6 Free"];
            size = 14.0;
          };
          colors = {
            background = "#282a2e";
            statusline = "#ffffff";
            separator = "#373b41";
          };
          extraConfig = ''
            separator_symbol "|"
          '';
        }
      ];
      gaps = {
        inner = 4;
        outer = 3;
      };
      keybindings = let
        modifier = "Mod4";
      in
        pkgs.lib.mkOptionDefault {
          # Core shortcuts
          "${modifier}+Return" = "exec ghostty";
          "${modifier}+d" = "exec rofi -show drun";
          "${modifier}+q" = "kill";
          "${modifier}+Shift+r" = "reload";
          "${modifier}+Shift+s" = "exec flameshot gui";
          "${modifier}+l" = "exec light-locker-command --lock";
          "${modifier}+Tab" = "exec rofi -show window";

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

          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        };
    };
    extraConfig = ''
      # default_border pixel 3

      # font pango:JetBrainsMono Nerd Font 14
      exec --no-startup-id i3-msg workspace 1
      workspace 1 output DP-1
      # startup
      exec --no-startup-id sh -c "feh --bg-fill $(cat ~/.cache/wallpaper_current)"
      exec --no-startup-id fcitx5
      exec --no-startup-id dunst
      exec --no-startup-id blueman-applet
      exec --no-startup-id light-locker --lock-on-suspend

      # float window
      for_window [class="missioncenter"] floating enable, resize set 1100px 750px, move position center
      for_window [class="[Bb]lueman-manager"] floating enable, resize set 800px 600px, move position center
      for_window [class="cava"] floating enable, resize set 1000px 600px, move position center
      for_window [class="mpv"] floating enable, move position center
      for_window [class="imv"] floating enable, move position center
      for_window [class="fcitx5-config-qt"] floating enable, move position center
      for_window [class="(?i)xdm-app"] floating enable, resize set 1000px 650px, move position center
    '';
  };
}
