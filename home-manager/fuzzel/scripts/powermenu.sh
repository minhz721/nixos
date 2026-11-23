options=(
	"⚡ Power Off"
	"🔄 Reboot"
	"🔒 Lock Screen"
	"🌙 Suspend"
	"🚪 Log Out"
)

choice=$(
	printf '%s\n' "${options[@]}" |
		fuzzel --dmenu --no-exit-on-keyboard-focus-loss --index --lines=5 --minimal-lines --width=25 --prompt="⚡ Power Menu: "
) || exit 0

case "$choice" in
0) systemctl poweroff ;;
1) systemctl reboot ;;
2) hyprlock ;;
3) systemctl suspend ;;
4) swaymsg exit ;;
esac
