{
  pkgs,
  lib,
  ...
}: let
  mod = "Mod4";

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
in {
  home.packages = with pkgs; [
    libnotify
    wl-clipboard
    swaybg
    wlr-randr
    grim
    slurp
    jq
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = null;

    extraConfig = ''
      exec --no-startup-id swaymsg workspace 1
      client.focused          #f9e2af   #f9e2af   #1e1e2e   #f9e2af     #f9e2af
      client.focused_inactive #313244   #313244   #cdd6f4   #313244     #313244
      client.unfocused        #1e1e2e   #1e1e2e   #cdd6f4   #1e1e2e     #1e1e2e
    '';

    config = {
      modifier = mod;
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
        {command = "sh -c 'swaybg -i \"$(cat ~/.cache/wallpaper_current)\" -m fill'";}
        {command = "fcitx5 -d";}
        {command = "blueman-applet";}
      ];
      bars = [
        {command = "${pkgs.waybar}/bin/waybar";}
      ];
      window = {
        border = 2;
        titlebar = false;
        commands =
          map (criteria: {
            command = "floating enable, move position center";
            inherit criteria;
          }) [
            {app_id = "^(mpv|imv|cava|\\.blueman-manager-wrapped|blueman-manager|org\\.fcitx\\.)$";}
            {title = "(?i)Mission Center";}
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
        "${mod}+Shift+s" = "exec ${screenshot}/bin/screenshot region";
        "${mod}+p" = "exec ${screenshot}/bin/screenshot full";

        # Apps
        "${mod}+e" = "exec nemo";
        "${mod}+b" = "exec thorium";
        "${mod}+c" = "exec zeditor";

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
