#!/usr/bin/env bash

# input method
fcitx5 -d

# Load notification service
dunst &

# Setup Wallpaper and update colors
feh --bg-fill "$(cat ~/.cache/wallpaper_current)" &

blueman-applet &

# Load picom
#!/bin/sh
picom -b &

light-locker --lock-on-suspend &

# ab-download-manager --background &

# xrandr \
#   --output DisplayPort-0 \
#   --mode 2560x1440 \
#   --rate 200 \
#   --primary \
#   --pos 0x0 \
#   --output HDMI-A-0 \
#   --mode 1920x1080 \
#   --rate 60 \
#   --pos 320x1440