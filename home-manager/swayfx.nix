{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libnotify
    wl-clipboard
    swaybg
    wlr-randr
    grim
    slurp
    jq
  ];

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      font = "Maple Mono";
      background-color = "#1e1e2eff";
      text-color = "#cdd6f4ff";
      border-color = "#cba6f7ff";
      border-size = 2;
      border-radius = 8;
      margin = "10,10";
      padding = "10";
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
          font_family = "Maple Mono";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  wayland.windowManager.sway = {
    extraConfig = ''
      default_border pixel 2
      client.focused          #f9e2af   #f9e2af   #1e1e2e   #f9e2af     #f9e2af
      client.focused_inactive #313244   #313244   #cdd6f4   #313244     #313244
      client.unfocused        #1e1e2e   #1e1e2e   #cdd6f4   #1e1e2e     #1e1e2e
    '';
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "ghostty";
      menu = "fuzzel";
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
        {command = "sh -c 'swaybg -i $(cat ~/.cache/wallpaper_current) -m fill'";}
        {command = "fcitx5 -d";}
        {command = "mako";}
        {command = "blueman-applet";}
      ];
      bars = [
        {command = "${pkgs.waybar}/bin/waybar";}
      ];
      window = {
        border = 8;
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
          "${modifier}+b" = "exec google-chrome";
          "${modifier}+c" = "exec gram";

          # Window layout controls
          "${modifier}+f" = "floating toggle";
          "${modifier}+Shift+f" = "focus mode_toggle";

          # Direct window resizing using arrow keys
          "${modifier}+Ctrl+Left" = "resize shrink width 20 px";
          "${modifier}+Ctrl+Down" = "resize grow height 20 px";
          "${modifier}+Ctrl+Up" = "resize shrink height 20 px";
          "${modifier}+Ctrl+Right" = "resize grow width 20 px";

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

  xdg.configFile."thorium-flags.conf".text = ''
    --ozone-platform-hint=auto
    --ozone-platform=wayland
    --enable-features=WaylandWindowDecorations
  '';
  xdg.configFile."chrome-flags.conf".text = ''
    --ozone-platform-hint=auto
    --ozone-platform=wayland
    --enable-features=WaylandWindowDecorations,WebRTCPipeWireCapturer
  '';
}
