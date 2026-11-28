#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"

# Main Control Center menu
options=(
	"  Change Wallpaper"
	"  Power Off"
	"  Reboot"
	"  Lock Screen"
)

choice=$(
	printf '%s\n' "${options[@]}" |
		fuzzel --dmenu --index --lines="${#options[@]}" --width=26 --prompt=" Control Center: "
) || exit 0

case "$choice" in
0)
	exec "$SCRIPT_DIR/wallpaper.sh"
	;;
1)
	systemctl poweroff
	;;
2)
	systemctl reboot
	;;
3)
	setsid -f hyprlock >/dev/null 2>&1
	;;
esac
