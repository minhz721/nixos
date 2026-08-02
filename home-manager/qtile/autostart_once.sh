#!/bin/bash

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


xfce4-screensaver &

xautolock \
    -detectsleep \
    -time 10 \
    -locker "xfce4-screensaver-command --lock" &
    