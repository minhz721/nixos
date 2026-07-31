#!/usr/bin/env bash

DIR="$HOME/Pictures/wallpaper"

wallpaper=$(find "$DIR" -type f \
    | fuzzel --dmenu --prompt "Wallpaper")

[ -z "$wallpaper" ] && exit

pkill swaybg
swaybg -i "$wallpaper" -m fill &

# Optional
wal -i "$wallpaper"

pkill waybar
waybar &