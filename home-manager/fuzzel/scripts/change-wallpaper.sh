#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpaper}"
CACHE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper_current"
CONF_FILE="$HOME/.config/sway/modules/wallpaper"

apply_wallpaper() {
	local img="$1"
	[ -f "$img" ] || return 1

	mkdir -p "$(dirname "$CACHE_FILE")" "$(dirname "$CONF_FILE")"
	printf '%s\n' "$img" >"$CACHE_FILE"
	printf 'output * bg "%s" fill\n' "$img" >"$CONF_FILE"

	swaymsg "output * bg \"$img\" fill" >/dev/null 2>&1 || true
}

if [ "${1:-}" = "--init" ]; then
	img=""
	if [ -f "$CACHE_FILE" ]; then
		img="$(cat "$CACHE_FILE")"
	fi

	if [ -z "$img" ] || [ ! -f "$img" ]; then
		mapfile -t papers < <(
			find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) 2>/dev/null | sort
		)
		[ "${#papers[@]}" -gt 0 ] || exit 1
		img="${papers[RANDOM % ${#papers[@]}]}"
	fi

	apply_wallpaper "$img"
	exit 0
fi

wallpaper_selected=$(zenity --file-selection \
	--title="Select an image" \
	--filename="$WALLPAPER_DIR/" \
	--file-filter='Images | *.png *.jpg *.jpeg *.webp') || exit 0

[ -z "$wallpaper_selected" ] && exit 0

apply_wallpaper "$wallpaper_selected"
notify-send -t 2000 "Wallpaper" "${wallpaper_selected#"$WALLPAPER_DIR"/}" 2>/dev/null || true
