#!/bin/bash
# Move all monitors to the next/prev workspace in their own range simultaneously.
# Usage: global-workspace.sh r+1 | global-workspace.sh r-1
DIRECTION=$1
FOCUSED=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')

for MON in $(hyprctl monitors -j | jq -r 'sort_by(.x) | .[].name'); do
    hyprctl dispatch focusmonitor "$MON"
    hyprctl dispatch split:workspace "$DIRECTION"
done

hyprctl dispatch focusmonitor "$FOCUSED"
