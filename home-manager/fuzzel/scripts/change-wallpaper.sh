#!/usr/bin/env bash

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpaper}"
CACHE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper_current"
THUMB_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper_thumbs"

mapfile -t papers < <(
	find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) 2>/dev/null | sort
)

if [ "${#papers[@]}" -eq 0 ]; then
	notify-send -u critical "Wallpaper" "No images found in $WALLPAPER_DIR" 2>/dev/null || true
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

# Initialize wallpaper on Sway startup
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

# Generate 128x128 thumbnails for fast Fuzzel preview
mkdir -p "$THUMB_DIR"

menu() {
	local img rel thumb
	for img in "${papers[@]}"; do
		rel="${img#"$WALLPAPER_DIR"/}"
		thumb="$THUMB_DIR/$(printf '%s' "$rel" | tr '/' '_').png"

		if [ ! -f "$thumb" ]; then
			ffmpeg -loglevel error -i "$img" -vf "scale=128:128:force_original_aspect_ratio=increase,crop=128:128" -frames:v 1 "$thumb" 2>/dev/null || thumb="$img"
		fi

		printf '%s\0icon\x1f%s\n' "$rel" "$thumb"
	done
}

choice=$(menu | fuzzel --dmenu --index --lines=8 --width=45 --line-height=48 --prompt=" Wallpaper: ") || exit 0
img="${papers[$choice]}"

mkdir -p "$(dirname "$CACHE_FILE")"
printf '%s\n' "$img" >"$CACHE_FILE"
apply "$img"
notify-send -t 2000 "Wallpaper" "${img#"$WALLPAPER_DIR"/}" 2>/dev/null || true
