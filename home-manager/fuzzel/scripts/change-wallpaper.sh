#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpaper}"
CACHE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper_current"

apply_wallpaper() {
	local img="$1"
	[ -f "$img" ] || return 1

	# Remember the wallpaper only after sway accepted it.
	swaymsg "output * bg \"$img\" fill" >/dev/null || return 1

	mkdir -p "$(dirname "$CACHE_FILE")"
	printf '%s\n' "$img" >"$CACHE_FILE"
}

# `wallpaper.sh --restore` re-applies the last wallpaper (run it from the sway config).
if [ "${1:-}" = "--restore" ]; then
	[ -f "$CACHE_FILE" ] || exit 0
	apply_wallpaper "$(head -n1 "$CACHE_FILE")" || true
	exit 0
fi

wallpaper_selected=$(zenity --file-selection \
	--title="Select an image" \
	--filename="$WALLPAPER_DIR/" \
	--file-filter='Images | *.png *.PNG *.jpg *.JPG *.jpeg *.JPEG *.webp *.WEBP') || exit 0

if [ -z "$wallpaper_selected" ]; then
	exit 0
fi

if apply_wallpaper "$wallpaper_selected"; then
	notify-send -t 2000 "Wallpaper" "${wallpaper_selected#"$WALLPAPER_DIR"/}" 2>/dev/null || true
else
	notify-send -u critical "Wallpaper" "Failed to apply: $wallpaper_selected" 2>/dev/null || true
	exit 1
fi
