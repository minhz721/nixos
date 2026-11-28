{ config, pkgs, ... }:

let
  # Bluetooth status
  btCommand = pkgs.writeShellApplication {
    name = "i3rs-bt";
    runtimeInputs = with pkgs; [
      bluez
      coreutils
      gawk
    ];
    text = ''
      cache_dir="''${XDG_RUNTIME_DIR:-/tmp}/i3rs-bt-cache"

      # Adapter power state (bash pattern match, no extra process)
      show=$(bluetoothctl show 2>/dev/null || true)
      if [[ "$show" != *"Powered: yes"* ]]; then
        printf 'Off'
        exit 0
      fi

      # First connected device (no head needed)
      device=$(bluetoothctl devices Connected 2>/dev/null || true)
      device=''${device%%$'\n'*}
      device=''${device//$'\r'/}
      if [[ -z "$device" ]]; then
        printf ' On'
        exit 0
      fi

      device=''${device#Device }
      mac=''${device%% *}
      name=''${device#* }

      # Battery: refresh at most once per minute
      [[ -d "$cache_dir" ]] || mkdir -p "$cache_dir"
      cache_file="$cache_dir/$mac"
      now=$EPOCHSECONDS
      cached_at=0
      battery=""

      if [[ -f "$cache_file" ]]; then
        IFS='|' read -r cached_at battery < "$cache_file" || true
      fi

      if [[ ! "$cached_at" =~ ^[0-9]+$ ]] || ((now - cached_at >= 60)); then
        battery=$(
          bluetoothctl info "$mac" 2>/dev/null |
            awk '/Battery Percentage:/ {
              gsub(/[()\r]/, "", $NF)
              print $NF
              exit
            }' || true
        )
        printf '%s|%s\n' "$now" "$battery" > "$cache_file.tmp"
        mv "$cache_file.tmp" "$cache_file"
      fi

      if [[ "$battery" =~ ^[0-9]+$ ]]; then
        printf '%s (%s%%)' "$name" "$battery"
      else
        printf '%s' "$name"
      fi
    '';
  };

  btToggle = pkgs.writeShellApplication {
    name = "i3rs-bt-toggle";
    runtimeInputs = with pkgs; [
      bluez
      util-linux
    ];
    text = ''
      show=$(bluetoothctl show 2>/dev/null || true)
      case "$show" in
        *"Powered: yes"*)
          bluetoothctl power off
          ;;
        *)
          rfkill unblock bluetooth
          bluetoothctl power on
          ;;
      esac
    '';
  };

  imCommand = pkgs.writeShellApplication {
    name = "i3rs-im";
    runtimeInputs = [ pkgs.fcitx5 ];
    text = ''
      state=$(fcitx5-remote 2>/dev/null || true)
      if [ "$state" = "2" ]; then
        printf " VI"
      else
        im=$(fcitx5-remote -n 2>/dev/null || true)
        case "$im" in
          *unikey*|*viet*|*Bamboo*|*bamboo*|*lotus*) printf " VI" ;;
          *) printf " EN" ;;
        esac
      fi
    '';
  };
in
{
  xdg.configFile."fuzzel/scripts/control-center.sh" = {
    source = ./fuzzel/scripts/control-center.sh;
    executable = true;
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        icons = "material-nf";
        theme = "native";

        blocks = [
          {
            block = "cpu";
            interval = 3;
            format = " CPU: $utilization ";
            theme_overrides = {
              idle_fg = "#a6e3a1";
              good_fg = "#a6e3a1";
              info_fg = "#a6e3a1";
              warning_fg = "#f9e2af";
              critical_fg = "#ff0048";
            };
          }

          {
            block = "temperature";
            format = "  $max ";
            interval = 10;
            theme_overrides = {
              idle_fg = "#f38ba8";
              good_fg = "#f38ba8";
              info_fg = "#f38ba8";
              warning_fg = "#ff0048";
            };
          }

          {
            block = "memory";
            format = " RAM: $mem_used.eng(w:4) ";
            interval = 3;
            theme_overrides = {
              idle_fg = "#94e2d5";
            };
          }

          {
            block = "sound";
            format = " $icon {$volume|mute} ";
            show_volume_when_muted = true;
            step_width = 5;
            max_vol = 100;
            theme_overrides = {
              idle_fg = "#f9e2af";
            };
            click = [
              {
                button = "right";
                cmd = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
              }
            ];
          }

          {
            block = "custom";
            interval = 3;
            command = "${btCommand}/bin/i3rs-bt";
            format = " $text ";
            theme_overrides = {
              idle_fg = "#89b4fa";
            };
            click = [
              {
                button = "left";
                cmd = "${pkgs.blueman}/bin/blueman-manager";
              }
              {
                button = "right";
                cmd = "${btToggle}/bin/i3rs-bt-toggle";
              }
            ];
          }

          {
            block = "custom";
            interval = 1;
            command = "${imCommand}/bin/i3rs-im";
            format = " $text ";
            theme_overrides = {
              idle_fg = "#cba6f7";
            };
            click = [
              {
                button = "left";
                cmd = "${pkgs.fcitx5}/bin/fcitx5-remote -t";
              }
            ];
          }

          {
            block = "time";
            format = "  $timestamp.datetime(f:'%H:%M')  $timestamp.datetime(f:'%d/%m/%y') ";
            interval = 5;
            theme_overrides = {
              idle_fg = "#dbb35c";
            };
          }

          {
            block = "custom";
            command = "echo ''";
            interval = "once";
            format = " $text ";
            theme_overrides = {
              idle_fg = "#cdd6f4";
            };
            click = [
              {
                button = "left";
                cmd = "${config.xdg.configHome}/fuzzel/scripts/control-center.sh";
              }
            ];
          }
        ];
      };
    };
  };
}
