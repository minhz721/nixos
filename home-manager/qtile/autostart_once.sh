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

ab-download-manager --background &
