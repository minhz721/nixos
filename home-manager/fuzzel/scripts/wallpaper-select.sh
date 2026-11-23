WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpaper}"
CACHE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper_current"

mapfile -t papers < <(
	find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) 2>/dev/null | sort
)

if [ "${#papers[@]}" -eq 0 ]; then
	notify-send -u critical "Wallpaper" "Not found $WALLPAPER_DIR"
	exit 1
fi

apply() {
	local img="$1"
	local -a old
	mapfile -t old < <(pgrep -x swaybg || true)
	setsid -f swaybg -i "$img" -m fill >/dev/null 2>&1
	sleep 0.3
	if [ "${#old[@]}" -gt 0 ]; then
		kill "${old[@]}" 2>/dev/null || true
	fi
}

if [ "${1:-}" = "--init" ]; then
	img=""
	if [ -f "$CACHE_FILE" ]; then
		img="$(cat "$CACHE_FILE")"
	fi
	if [ ! -f "$img" ]; then
		img="${papers[RANDOM % ${#papers[@]}]}"
	fi
	apply "$img"
	exit 0
fi

menu() {
	local img
	for img in "${papers[@]}"; do
		printf '%s\0icon\x1f%s\n' "${img#"$WALLPAPER_DIR"/}" "$img"
	done
}

choice=$(menu | fuzzel --dmenu --no-exit-on-keyboard-focus-loss --index --lines=10 --prompt "Wallpaper: ") || exit 0
img="${papers[$choice]}"

mkdir -p "$(dirname "$CACHE_FILE")"
printf '%s\n' "$img" >"$CACHE_FILE"
apply "$img"
notify-send "Wallpaper" "${img#"$WALLPAPER_DIR"/}"
