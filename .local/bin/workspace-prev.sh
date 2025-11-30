#!/bin/bash
# Move to previous workspace with animation, optionally moving focused window

cur=$(xdotool get_desktop)
target=$((cur - 1))
if [ "$target" -lt 0 ]; then
  target=8
fi

# If "move" argument is passed, move the focused window first
if [ "$1" = "move" ]; then
    focused_window=$(xdotool getactivewindow 2>/dev/null)
    if [ -n "$focused_window" ]; then
        xdotool set_desktop_for_window "$focused_window" "$target"
    fi
fi

/home/lain/.local/bin/workspace-switch.sh "$target"
