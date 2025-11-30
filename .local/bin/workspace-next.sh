#!/bin/bash
cur=$(xdotool get_desktop)
target=$((cur + 1))
# wrap 0..8 if you have 9 workspaces
if [ "$target" -gt 8 ]; then
  target=0
fi
/home/lain/.local/bin/workspace-switch.sh "$target"
