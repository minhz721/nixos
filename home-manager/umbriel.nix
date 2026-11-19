{
  config,
  pkgs,
  inputs,
  ...
}: let
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    text = ''
      dir="''${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
      mkdir -p "$dir"
      file="$dir/$(date +'%Y-%m-%d_%H-%M-%S').png"

      case "''${1:-region}" in
        region)
          geometry="$(slurp)" || exit 0
          grim -g "$geometry" "$file"
          ;;
        full)
          grim "$file"
          ;;
        *)
          echo "usage: screenshot [region|full]" >&2
          exit 1
          ;;
      esac

      wl-copy --type image/png < "$file"
      notify-send -t 2000 "Screenshot saved" "$file"
    '';
  };

  google-chrome-flags = ''
    --ozone-platform-hint=auto
    --enable-features=WebRTCPipeWireCapturer
  '';
in {
  imports = [
    inputs.umbriel.homeModules.default
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    libnotify
    wl-clipboard
    wlr-randr
    grim
    slurp
    jq
    screenshot
  ];

  programs.umbriel = {
    enable = true;
    settings = {
      general = {
        mod_key = "Super";
        default_layout = "scroll";
        autostart = [
          "fcitx5 -d"
          "blueman-applet"
        ];
      };

      gap = 6;

      layout = {
        default = "scroll";
      };

      input = {
        keyboard = {
          layout = "us";
        };
      };

      output = {
        "DP-1" = {
          mode = "2560x1440@200Hz";
          position = "0,0";
        };
        "HDMI-A-1" = {
          mode = "1920x1080@60Hz";
          position = "320,1440";
        };
      };

      environment = {
        NIXOS_OZONE_WL = "1";
      };

      keybinds = {
        # Launcher, Window Switcher, Wallpaper & Power/Session
        "Mod+D" = "spawn noctalia msg panel-toggle launcher";
        "Mod+Space" = "spawn noctalia msg panel-toggle launcher";
        "Mod+Tab" = "spawn noctalia msg panel-toggle windows";
        "Mod+W" = "spawn noctalia msg panel-toggle wallpaper";
        "Mod+Shift+X" = "spawn noctalia msg panel-toggle session";

        # Screenshot
        "Mod+Shift+S" = "spawn ${screenshot}/bin/screenshot region";
        "Mod+P" = "spawn ${screenshot}/bin/screenshot full";

        "Mod+Q" = "window-close";
        "Mod+Shift+R" = "config-reload";
        "Mod+L" = "spawn noctalia msg session lock";
        "Mod+T" = "layout-cycle";
        "Mod+F" = "fullscreen-toggle";
        "Mod+Shift+F" = "floating-toggle";

        # Application
        "Mod+Return" = "spawn alacritty";
        "Mod+E" = "spawn nemo";
        "Mod+B" = "spawn google-chrome";
        "Mod+C" = "spawn zeditor";

        # Resize window
        "Mod+Ctrl+Left" = "window-resize -20 0";
        "Mod+Ctrl+Down" = "window-resize 0 20";
        "Mod+Ctrl+Up" = "window-resize 0 -20";
        "Mod+Ctrl+Right" = "window-resize 20 0";

        "XF86AudioRaiseVolume" = "spawn wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
        "XF86AudioLowerVolume" = "spawn wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
        "XF86AudioMute" = "spawn wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "spawn wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };
    };
  };

  programs.noctalia = {
    enable = true;
    settings = {
      appLauncher = {
        enableClipboardHistory = true;
        terminalCommand = "alacritty -e";
        sortByMostUsed = true;
      };

      bar = {
        position = "top";
        density = "comfortable";
        showCapsule = true;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Workspace";
              hideUnoccupied = false;
              labelMode = "none";
            }
            {
              id = "Layout";
            }
          ];
          center = [
            {
              id = "Clock";
              formatHorizontal = "HH:mm  dd/MM/yyyy";
              useMonospacedFont = true;
            }
          ];
          right = [
            {
              id = "SystemMonitor";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "Wallpaper";
            }
            {
              id = "Session";
            }
          ];
        };
      };

      wallpaper = {
        enabled = true;
        fillMode = "crop";
        default = {
          path = "${config.home.homeDirectory}/Pictures/wallpaper.jpg";
        };
      };

      location = {
        name = "Hanoi, Vietnam";
        monthBeforeDay = false;
      };
    };
  };

  xdg.configFile."chrome-flags.conf".text = google-chrome-flags;
}
