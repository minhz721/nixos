{
  pkgs,
  inputs,
  lib,
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

  mkWorkspaceBinds = lib.listToAttrs (
    lib.concatMap (n: let
      num = toString n;
    in [
      {
        name = "Mod+${num}";
        value = "workspace-switch ${num}";
      }
      {
        name = "Mod+Shift+${num}";
        value = "window-move-to-workspace ${num}";
      }
    ]) (lib.range 1 9)
  );
in {
  imports = [
    inputs.umbriel.homeModules.default
  ];

  home.packages = with pkgs; [
    libnotify
    wl-clipboard
    swaybg
    wlr-randr
    grim
    slurp
    jq
  ];

  programs.umbriel = {
    enable = true;
    settings = {
      general = {
        show_cheatsheet = false;
        mod_key = "Super";
        autostart = [
          "fcitx5 -d"
          "waybar"
          "sh -c 'swaybg -i \"$(cat ~/.cache/wallpaper_current)\" -m fill'"
          "blueman-applet"
        ];
      };
      layout = {
        mode = "dwindle";
      };
      input = {
        keyboard = {
          layout = "us";
        };
      };
      output = {
        "DP-1" = {
          mode = "2560x1440@200";
          position = [0 0];
        };
        "HDMI-A-1" = {
          mode = "1920x1080@60";
          position = [320 1440];
        };
      };
      environment = {
        NIXOS_OZONE_WL = "1";
        XMODIFIERS = "@im=fcitx";
        QT_IM_MODULE = "fcitx";
        GTK_IM_MODULE = "fcitx";
        SDL_IM_MODULE = "fcitx";
      };
      window_rule =
        map (criteria: {
          match = criteria;
          default_floating = true;
          default_position = {
            x = 0;
            y = 0;
            anchor = "center";
          };
        }) [
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

      keybinds =
        mkWorkspaceBinds
        // {
          # Screenshot
          "Mod+Shift+S" = "spawn ${screenshot}/bin/screenshot region";
          "Mod+P" = "spawn ${screenshot}/bin/screenshot full";

          # Window management
          "Mod+Q" = "window-close";
          "Mod+Shift+R" = "config-reload";
          "Mod+L" = "spawn hyprlock";

          # Layout
          "Mod+T" = "workspace-set-layout toggle";
          "Mod+F" = "window-toggle-fullscreen";
          "Mod+Shift+F" = "window-toggle-floating";

          # Applications
          "Mod+D" = "spawn fuzzel";
          "Mod+Return" = "spawn alacritty";
          "Mod+E" = "spawn nemo";
          "Mod+B" = "spawn thorium";
          "Mod+C" = "spawn zeditor";

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
}
