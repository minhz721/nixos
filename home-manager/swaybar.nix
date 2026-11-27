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
      set -euo pipefail
      CACHE_DIR="''${XDG_RUNTIME_DIR:-/tmp}/i3rs-bt-cache"
      mkdir -p "$CACHE_DIR"
      # Check Bluetooth power
      if ! bluetoothctl show 2>/dev/null |
        awk '/Powered: yes/ { found=1 } END { exit !found }'; then
        printf 'Off'
        exit 0
      fi

      # Find connected device
      device=$(bluetoothctl devices Connected 2>/dev/null | head -n 1 || true)
      if [[ -z "$device" ]]; then
        printf ' On'
        exit 0
      fi

      # Extract MAC and device name
      device="''${device#Device }"
      mac="''${device%% *}"
      name="''${device#* }"

      # Battery cache
      cache_file="$CACHE_DIR/$mac"
      now=$(date +%s)
      cached_at=0
      battery=""

      if [[ -f "$cache_file" ]]; then
        IFS='|' read -r cached_at battery < "$cache_file" || true
      fi

      # Refresh battery every 60 seconds
      if [[ ! "$cached_at" =~ ^[0-9]+$ ]] ||
        (( now - cached_at >= 60 )); then
        battery=$(
          bluetoothctl info "$mac" 2>/dev/null |
            awk '/Battery Percentage:/ {
              gsub(/[()]/, "", $NF)
              print $NF
              exit
            }' || true
        )

        tmp_file="$cache_file.tmp"
        printf '%s|%s\n' "$now" "''${battery:-}" > "$tmp_file"
        mv "$tmp_file" "$cache_file"
      fi

      if [[ "$battery" =~ ^[0-9]+$ ]]; then
        printf '%s (%s%%)' "$name" "$battery"
      else
        printf '%s' "$name"
      fi
    '';
  };

  # Bluetooth toggle
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

  # Fcitx5 status
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
          *unikey*|*viet*|*Bamboo*|*bamboo*|*lotus*)
            printf " VI"
            ;;
          *)
            printf " EN"
            ;;
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
    bars.default = {
      icons = "material-nf";
      theme = "native";
      blocks = [
        # CPU
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

        # Temperature
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

        # RAM
        {
          block = "memory";
          format = " RAM: $mem_used.eng(w:4) ";
          interval = 3;
          theme_overrides = {
            idle_fg = "#94e2d5";
          };
        }

        # Sound
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

        # Bluetooth
        {
          block = "custom";
          interval = 1;
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

        # Fcitx5
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

        # Time
        {
          block = "time";
          format = "  $timestamp.datetime(f:'%H:%M')  $timestamp.datetime(f:'%d/%m/%y') ";
          interval = 5;
          theme_overrides = {
            idle_fg = "#dbb35c";
          };
        }

        # Control Center
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
}
