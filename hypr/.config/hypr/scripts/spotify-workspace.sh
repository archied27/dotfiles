#!/usr/bin/env bash

WORKSPACE=20

notify-send "Running spotify-workspace script"

# Immediately switch to workspace 20
hyprctl dispatch workspace "$WORKSPACE"

# Check if Spotify (via spotify-launcher) is already running
if ! pgrep -f "spotify" > /dev/null; then
    notify-send "Spotify not running — launching it!"
    spotify-launcher &
else
    notify-send "Spotify already running!"
fi

