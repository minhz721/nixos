{ config, pkgs, ... }:

let
  btCommand = pkgs.writeShellApplication {
    name = "i3rs-bt";
    runtimeInputs = with pkgs; [
      bluez
      gawk
      gnused
      coreutils
    ];
    text = ''
      powered=$(bluetoothctl show 2>/dev/null | sed -E 's/\x1b\[[0-9;]*m//g; s/\r//g' | awk '/Powered:/{print $2}')
      if [ "$powered" != "yes" ]; then
        printf "   Off"
        exit 0
      fi

      dev=$(bluetoothctl devices Connected 2>/dev/null | sed -E 's/\x1b\[[0-9;]*m//g; s/\r//g' | head -n1)
      if [ -z "$dev" ]; then
        printf " On"
      else
        mac=$(printf '%s\n' "$dev" | awk '{print $2}')
        name=$(printf '%s\n' "$dev" | cut -d' ' -f3-)
        bat=$(bluetoothctl info "$mac" 2>/dev/null | sed -E 's/\x1b\[[0-9;]*m//g; s/\r//g' | sed -n 's/.*Battery Percentage:.*(\([0-9]*\)).*/\1/p')
        if [ -n "$bat" ]; then
          printf "   %s (%s%%)" "$name" "$bat"
        else
          printf "   %s" "$name"
        fi
      fi
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
          *unikey*|*viet*|*Bamboo*|*bamboo*) printf " VI" ;;
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
            interval = 2;
            format = "  $utilization ";
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
            interval = 2;
            theme_overrides = {
              idle_fg = "#f38ba8";
              good_fg = "#f38ba8";
              info_fg = "#f38ba8";
              warning_fg = "#ff0048";
            };
          }

          {
            block = "memory";
            format = "   $mem_used.eng(w:4) ";
            interval = 2;
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
            interval = 60;
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
                cmd = "${pkgs.bash}/bin/bash -c '${pkgs.bluez}/bin/bluetoothctl show | grep -q \"Powered: yes\" && ${pkgs.bluez}/bin/bluetoothctl power off || (${pkgs.util-linux}/bin/rfkill unblock bluetooth; ${pkgs.bluez}/bin/bluetoothctl power on)'";
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
            format = "  $timestamp.datetime(f:'%H:%M')   $timestamp.datetime(f:'%d/%m/%y') ";
            interval = 5;
            theme_overrides = {
              idle_fg = "#dbb35c";
            };
          }

          # 8. Control Center
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
