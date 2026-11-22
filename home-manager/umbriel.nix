{
  pkgs,
  inputs,
  lib,
  ...
}:
let
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

  mkWorkspaceBinds = lib.listToAttrs (
    lib.concatMap (
      n:
      let
        num = toString n;
      in
      [
        {
          name = "Mod+${num}";
          value = "workspace-switch ${num}";
        }
        {
          name = "Mod+Shift+${num}";
          value = "window-move-to-workspace ${num}";
        }
      ]
    ) (lib.range 1 9)
  );
in
{
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
  ];

  programs.umbriel = {
    enable = true;
    settings = {
      general = {
        show_cheatsheet = false;
        mod_key = "Super";
        autostart = [
          "fcitx5 -d"
          "noctalia"
        ];
      };
      layout = {
        mode = "scrolling";
        scrolling = {
          default_extent_fraction = 0.5;
          center_underfull_strip = true;
        };
      };
      input = {
        keyboard = {
          layout = "us";
        };
        focus = {
          follows_mouse = "always";
        };
      };
      output = {
        "DP-1" = {
          mode = "2560x1440@200";
          position = [
            0
            0
          ];
        };
        "HDMI-A-1" = {
          mode = "1920x1080@60";
          position = [
            320
            1440
          ];
        };
      };

      window_rule =
        map
          (criteria: {
            match = criteria;
            default_floating = true;
            default_position = {
              x = 0;
              y = 0;
              anchor = "center";
            };
          })
          [
            {
              app_id = "^(mpv|imv|cava|\\.blueman-manager-wrapped|blueman-manager)$|^org\\.fcitx\\..*";
            }
            {
              title = "^[Mm]ission [Cc]enter$";
            }
            {
              app_id = "^org\\.fcitx\\.Fcitx5\\.Addon\\.Lotus\\.Settings$";
              title = "^Lotus Settings$";
            }
          ];

      keybinds = mkWorkspaceBinds // {
        "Alt+Tab" = "spawn noctalia msg window-switcher hold";
        "Alt+Shift+Tab" = "spawn noctalia msg window-switcher hold reverse";

        # Screenshot
        "Mod+Shift+S" = "spawn ${screenshot}/bin/screenshot region";
        "Mod+P" = "spawn ${screenshot}/bin/screenshot full";

        # Window management
        "Mod+Q" = "window-close";
        "Mod+Shift+R" = "config-reload";
        "Mod+L" = "spawn noctalia msg session lock";

        # Layout
        # "Mod+T" = "workspace-set-layout toggle";
        "Mod+F" = "window-toggle-fullscreen";
        "Mod+Shift+F" = "window-toggle-floating";
        "Mod+Ctrl+F" = "window-toggle-maximize";

        # Applications
        "Mod+D" = "spawn noctalia msg panel-toggle launcher";
        "Mod+Return" = "spawn ghostty";
        "Mod+E" = "spawn nemo";
        "Mod+B" = "spawn thorium";
        "Mod+C" = "spawn zeditor";

        # Window
        "Mod+Left" = "window-focus-left";
        "Mod+Right" = "window-focus-right";
        "Mod+Up" = "window-focus-up";
        "Mod+Down" = "window-focus-down";
        "Mod+WheelDown" = "layout-scroll-right";
        "Mod+WheelUp" = "layout-scroll-left";
        "Mod+Shift+WheelDown" = "window-focus-right";
        "Mod+Shift+WheelUp" = "window-focus-left";

        # Resize
        "Mod+Ctrl+Left" = "window-modify-primary-extent -0.02";
        "Mod+Ctrl+Right" = "window-modify-primary-extent +0.02";
        "Mod+Ctrl+Up" = "window-modify-secondary-extent -0.02";
        "Mod+Ctrl+Down" = "window-modify-secondary-extent +0.02";

        # Audio
        "XF86AudioRaiseVolume" = "spawn wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
        "XF86AudioLowerVolume" = "spawn wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
        "XF86AudioMute" = "spawn wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "spawn wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };
    };
  };

  programs.noctalia = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      shell = {
        font_family = "Maple Mono NF";
      };
      bar = {
        default = {
          enabled = true;
          position = "top";
          capsule = true;
          start = [
            "control-center"
            "workspaces"
          ];
          center = [
            "clock"
          ];
          end = [
            "cpu"
            "temp"
            "ram"
            "volume"
            "clipboard"
            "bluetooth"
            "tray"
            "wallpaper"
            "session"
          ];
        };
      };
      widget = {
        cpu = {
          type = "sysmon";
          stat = "cpu_usage";
          show_value = true;
          show_glyph = true;
        };
        temp = {
          type = "sysmon";
          stat = "cpu_temp";
          show_value = true;
          show_glyph = true;
        };
        ram = {
          type = "sysmon";
          stat = "ram_used";
          show_value = true;
          show_glyph = true;
        };
        clock = {
          format = "{:%H:%M} {:%d/%m/%Y}";
        };
        workspaces = {
          show_labels = true;
          labels_only_when_occupied = false;
        };
      };
      location = {
        auto_locate = true;
      };
    };
  };
}
