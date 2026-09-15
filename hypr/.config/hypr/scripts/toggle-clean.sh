#!/bin/bash

STATEFILE="$HOME/.cache/hypr-cleanmode"

if [ -f "$STATEFILE" ]; then
    # Disable clean mode → restore defaults
    hyprctl keyword decoration:rounding 8
    hyprctl keyword general:border_size 2
    hyprctl keyword general:gaps_in 5
    hyprctl keyword general:gaps_out 12
    pkill -SIGUSR1 waybar
    rm "$STATEFILE"
else
    # Enable clean mode
    hyprctl keyword decoration:rounding 0
    hyprctl keyword general:border_size 0
    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
    pkill -SIGUSR1 waybar
    touch "$STATEFILE"
fi
