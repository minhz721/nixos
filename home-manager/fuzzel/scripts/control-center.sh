#!/usr/bin/env bash

THEME_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/current-theme"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
mkdir -p "$THEME_DIR"

# Import theme definitions
# shellcheck source=/dev/null
source "$SCRIPT_DIR/themes.sh"

apply_theme() {
	local name="$1"
	local bg surface overlay muted fg subtext accent border_alt yellow blue green teal red

	load_theme_palette "$name" || return 1

	# 1. Generate CSS color variables for Waybar
	cat >"$THEME_DIR/waybar.css" <<EOF
@define-color bg $bg;
@define-color surface $surface;
@define-color overlay $overlay;
@define-color muted $muted;
@define-color fg $fg;
@define-color subtext $subtext;
@define-color accent $accent;
@define-color yellow $yellow;
@define-color blue $blue;
@define-color green $green;
@define-color teal $teal;
@define-color red $red;
EOF

	# 2. Generate color configuration for Fuzzel
	cat >"$THEME_DIR/fuzzel.ini" <<EOF
[colors]
background=${bg:1}ff
text=${fg:1}ff
match=${red:1}ff
selection=${overlay:1}ff
selection-text=${fg:1}ff
selection-match=${red:1}ff
border=${border_alt:1}ff
EOF

	# 3. Write configuration and colors directly for Mako
	mkdir -p "$HOME/.config/mako"
	cat >"$HOME/.config/mako/config" <<EOF
default-timeout=5000
font=Maple Mono NF
background-color=${bg}ff
text-color=${fg}ff
border-color=${accent}ff
border-size=2
border-radius=8
margin=10,10
padding=10
EOF

	# 4. Update SwayFX window borders immediately
	swaymsg "client.focused $yellow $yellow $bg $yellow $yellow" >/dev/null 2>&1 || true
	swaymsg "client.focused_inactive $surface $surface $fg $surface $surface" >/dev/null 2>&1 || true
	swaymsg "client.unfocused $bg $bg $fg $bg $bg" >/dev/null 2>&1 || true

	# 5. Hot-reload Waybar and Mako
	pkill -USR2 waybar 2>/dev/null || true
	makoctl reload 2>/dev/null || true
	notify-send -t 2000 "Theme" "Switched to $name" 2>/dev/null || true
}

# Initialize default theme on startup if cache does not exist
if [ "${1:-}" = "--init" ]; then
	if [ ! -f "$THEME_DIR/waybar.css" ] && [ "${#THEME_LIST[@]}" -gt 0 ]; then
		apply_theme "${THEME_LIST[0]}"
	fi
	exit 0
fi

# Main Control Center menu
options=(
	"  Change Theme"
	"  Change Wallpaper"
	"  Suspend"
	"󰍃  Log out"
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
	t_choice=$(
		printf '%s\n' "${THEME_LIST[@]}" |
			fuzzel --dmenu --index --lines="${#THEME_LIST[@]}" --width=26 --prompt=" Select Theme: "
	) || exit 0
	if [[ "$t_choice" =~ ^[0-9]+$ ]] && [ "$t_choice" -lt "${#THEME_LIST[@]}" ]; then
		apply_theme "${THEME_LIST[$t_choice]}"
	fi
	;;
1)
	exec "$SCRIPT_DIR/change-wallpaper.sh"
	;;
2)
	systemctl suspend
	;;
3)
	swaymsg exit
	;;
4)
	systemctl poweroff
	;;
5)
	systemctl reboot
	;;
6)
	setsid -f hyprlock >/dev/null 2>&1
	;;
esac
