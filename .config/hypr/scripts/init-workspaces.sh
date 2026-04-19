#!/bin/bash
# Initialize all 10 hyprsplit workspace groups and sync both monitors to group 1.
# Run once at startup after Hyprland is ready.

sleep 3

MONITORS=$(hyprctl monitors -j | jq -r 'sort_by(.x) | .[].name')
FOCUSED=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')

# Visit groups 10 down to 1 so we land on group 1 at the end
for i in $(seq 10 -1 1); do
    for MON in $MONITORS; do
        hyprctl dispatch focusmonitor "$MON"
        hyprctl dispatch split:workspace "$i"
    done
done

hyprctl dispatch focusmonitor "$FOCUSED"
