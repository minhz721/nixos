{
  config,
  pkgs,
  lib,
  ...
}: let
  mod = "Mod4";

  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [grim slurp wl-clipboard libnotify coreutils];
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

  browserFlags = ''
    --ozone-platform-hint=auto
    --enable-features=WebRTCPipeWireCapturer
  '';
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
          path = "${config.home.homeDirectory}/Pictures/wallpaper.jpg";
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
      terminal = "alacritty";
      menu = "fuzzel";
      output = {
        "DP-1" = {
          mode = "2560x1440@200Hz";
          pos = "0 0";
          adaptive_sync = "on";
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
            {app_id = "^(mpv|imv|cava|fcitx5-configtool|blueman-manager.*)$";}
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
        "${mod}+Tab" = "exec ${config.home.homeDirectory}/.config/fuzzel/scripts/sway-window-switcher.sh";

        # Screenshot
        "${mod}+Shift+s" = "exec ${screenshot}/bin/screenshot region";
        "Print" = "exec ${screenshot}/bin/screenshot full";

        # Apps
        "${mod}+e" = "exec nemo";
        "${mod}+b" = "exec thorium";
        "${mod}+c" = "exec gram";

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

  xdg.configFile."chrome-flags.conf".text = browserFlags;
}
