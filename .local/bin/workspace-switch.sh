#!/bin/bash
# Workspace switching script with picom animations
# Based on: https://github.com/yshui/picom/issues/1361

target_workspace=$1

# Get current workspace
current_workspace=$(xdotool get_desktop)

# Exit if already on target workspace
if [ "$current_workspace" -eq "$target_workspace" ]; then
    exit 0
fi

# Determine animation direction
if [ "$target_workspace" -gt "$current_workspace" ]; then
    # Moving to higher workspace (animate right)
    animation_value=1
else
    # Moving to lower workspace (animate left)
    animation_value=2
fi

# Get all window IDs using xdotool instead of wmctrl
windows=$(xdotool search --desktop "$current_workspace" --class "" 2>/dev/null)

# Set custom property on all windows
for win in $windows; do
    xprop -id "$win" -f _MY_CUSTOM_WORKSPACE_SWITCH 32i -set _MY_CUSTOM_WORKSPACE_SWITCH "$animation_value" 2>/dev/null
done

# Also set property on windows in the target workspace
target_windows=$(xdotool search --desktop "$target_workspace" --class "" 2>/dev/null)
for win in $target_windows; do
    xprop -id "$win" -f _MY_CUSTOM_WORKSPACE_SWITCH 32i -set _MY_CUSTOM_WORKSPACE_SWITCH "$animation_value" 2>/dev/null
done

# Switch workspace
xdotool set_desktop "$target_workspace"

# Clean up properties after animation completes
(sleep 0.5 && {
    for win in $windows $target_windows; do
        xprop -id "$win" -remove _MY_CUSTOM_WORKSPACE_SWITCH 2>/dev/null
    done
}) &
