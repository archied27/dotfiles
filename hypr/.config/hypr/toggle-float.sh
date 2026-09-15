#!/bin/bash
# ~/.config/hypr/scripts/toggle-float-all.sh

STATE_FILE="/tmp/hypr_allfloat"

clients=$(hyprctl clients -j)

if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
    # Tile all currently floating windows
    echo "$clients" | jq -r '.[] | select(.floating == true) | .address' | while read -r addr; do
        hyprctl dispatch settiled "address:$addr"
    done
else
    touch "$STATE_FILE"
    # Float all currently tiled windows
    echo "$clients" | jq -r '.[] | select(.floating == false) | .address' | while read -r addr; do
        hyprctl dispatch togglefloating "address:$addr"
    done
fi
