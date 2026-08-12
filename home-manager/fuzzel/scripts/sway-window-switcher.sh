#!/usr/bin/env bash

set -e

windows=$(
    swaymsg -t get_tree |
    jq -r '
        recurse(.nodes[]?, .floating_nodes[]?)
        | select(.type == "con")
        | select(.pid != null)
        | [
            .id,
            (.app_id // .window_properties.class // "unknown"),
            (.name // "Unnamed")
          ]
        | @tsv
    '
)

[ -z "$windows" ] && exit 0

selected=$(
    printf '%s\n' "$windows" |
    while IFS=$'\t' read -r id app title; do
        printf '%s\t%s — %s\n' "$id" "$app" "$title"
    done |
    fuzzel --dmenu --prompt "Window: "
)

[ -z "$selected" ] && exit 0

id=$(printf '%s' "$selected" | cut -f1)

swaymsg "[con_id=$id] focus"