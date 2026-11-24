#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpaper}"
CACHE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper_current"

apply_wallpaper() {
	local img="$1"
	[ -f "$img" ] || return 1

	mkdir -p "$(dirname "$CACHE_FILE")"
	printf '%s\n' "$img" >"$CACHE_FILE"

	swaymsg "output * bg \"$img\" fill" >/dev/null 2>&1 || true
}

wallpaper_selected=$(zenity --file-selection \
	--title="Select an image" \
	--filename="$WALLPAPER_DIR/" \
	--file-filter='Images | *.png *.jpg *.jpeg *.webp') || exit 0

[ -z "$wallpaper_selected" ] && exit 0

apply_wallpaper "$wallpaper_selected"
notify-send -t 2000 "Wallpaper" "${wallpaper_selected#"$WALLPAPER_DIR"/}" 2>/dev/null || true
