#!/bin/bash
# Move all monitors to the same workspace page simultaneously.
# Usage:
#   global-workspace.sh r+1        # relative next
#   global-workspace.sh r-1        # relative prev
#   global-workspace.sh 3          # jump all monitors to page 3
#   global-workspace.sh move 3     # move focused window to page 3, then jump all monitors there

FOCUSED=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')
MONITORS=$(hyprctl monitors -j | jq -r 'sort_by(.x) | .[].name')

if [[ "$1" == "move" ]]; then
    PAGE=$2
    # Move the active window to the corresponding workspace on the current monitor
    hyprctl dispatch split:movetoworkspace "$PAGE"
    # Then fall through to navigate all monitors to that page
    ARG="$PAGE"
else
    ARG="$1"
fi

for MON in $MONITORS; do
    hyprctl dispatch focusmonitor "$MON"
    hyprctl dispatch split:workspace "$ARG"
done

hyprctl dispatch focusmonitor "$FOCUSED"
