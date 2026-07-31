#!/usr/bin/env bash

# Options
op_poweroff="⚡ Power Off"
op_reboot="🔄 Reboot"
op_lock="🔒 Lock Screen"
op_suspend="🌙 Suspend"
op_logout="🚪 Log Out"

options="$op_poweroff\n$op_reboot\n$op_lock\n$op_suspend\n$op_logout"

# Launch Fuzzel in dmenu mode
chosen=$(echo -e "$options" | fuzzel --dmenu \
    --prompt="⚡ Power Menu: " \
    --lines=5 \
    --width=25 \
    --font="JetBrainsMono Nerd Font:size=12")

# Execute selected option
case "$chosen" in
    "$op_poweroff")
        systemctl poweroff
        ;;
    "$op_reboot")
        systemctl reboot
        ;;
    "$op_lock")
        swaylock
        ;;
    "$op_suspend")
        systemctl suspend
        ;;
    "$op_logout")
        niri msg action quit
        ;;
esac