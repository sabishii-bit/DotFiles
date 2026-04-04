#!/bin/bash
# Move all monitors to the same workspace page simultaneously.
# Usage:
#   global-workspace.sh r+1          # relative next
#   global-workspace.sh r-1          # relative prev
#   global-workspace.sh 3            # jump all monitors to page 3
#   global-workspace.sh move 3       # move focused window to page 3, sync all monitors
#   global-workspace.sh move r+1     # move focused window to next page, sync all monitors
#   global-workspace.sh move r-1     # move focused window to prev page, sync all monitors

FOCUSED=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')
MONITORS=$(hyprctl monitors -j | jq -r 'sort_by(.x) | .[].name')

if [[ "$1" == "move" ]]; then
    ARG="$2"
    # Move silently so the view doesn't follow, then navigate all monitors below
    hyprctl dispatch split:movetoworkspacesilent "$ARG"
else
    ARG="$1"
fi

# Navigate all monitors to the new page
for MON in $MONITORS; do
    hyprctl dispatch focusmonitor "$MON"
    hyprctl dispatch split:workspace "$ARG"
done

hyprctl dispatch focusmonitor "$FOCUSED"
