#!/usr/bin/env bash

# Path to the directory containing wallpaper images
WALLPAPER_DIR="$HOME/Pictures/wallpaper"

# Cache file storing the path of the currently active wallpaper
CACHE_FILE="$HOME/.cache/wallpaper_current"

# Fuzzel dmenu command configured to display 10 lines
ROFI_CMD="fuzzel --dmenu --lines=10 --prompt='Select Wallpaper: '"

# Scan and collect wallpaper files (jpg, jpeg, png) into an array
mapfile -t PAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)

# Initialize the last saved wallpaper from cache on system startup
if [ "$1" = "--init" ]; then
    if [ -f "$CACHE_FILE" ]; then
        OLD_PATH=$(cat "$CACHE_FILE")
        if [ -f "$OLD_PATH" ]; then
            pkill swaybg
            swaybg -i "$OLD_PATH" -m fill &
            exit 0
        fi
    fi
    # Fallback: Pick a random wallpaper if the cache is empty
    pkill swaybg
    swaybg -i "${PAPERS[RANDOM % ${#PAPERS[@]}]}" -m fill &
    exit 0
fi

# Generate the menu structure passing filenames and thumbnail icon paths to Fuzzel
generate_menu() {
    for img in "${PAPERS[@]}"; do
        filename=$(basename "$img")
        printf "%s\x00icon\x1f%s\n" "$filename" "$img"
    done
}

# Launch Fuzzel and capture the user selection
SELECTED_NAME=$(generate_menu | $ROFI_CMD)

# Exit immediately if the user cancels the selection (e.g., presses Escape)
[ -z "$SELECTED_NAME" ] && echo "No choice selected. Exiting." && exit 0

# Reconstruct the absolute target path to the chosen image file
FULL_PATH="$WALLPAPER_DIR/$SELECTED_NAME"

# Fallback validation to verify the target wallpaper file exists locally
if [ ! -f "$FULL_PATH" ]; then
    echo "Error: Target image file not found on system."
    exit 1
fi

# Write the final choice location data out to system cache
echo "$FULL_PATH" > "$CACHE_FILE"

# Apply the graphic directly to the monitor matrix via swaybg
pkill swaybg
swaybg -i "$FULL_PATH" -m fill &

# Trigger a system notification indicating operational success
notify-send "System Wallpaper Applied" "Active: $SELECTED_NAME"
