#!/bin/bash
cur=$(xdotool get_desktop)
target=$((cur - 1))
if [ "$target" -lt 0 ]; then
  target=8
fi
/home/lain/.local/bin/workspace-switch.sh "$target"
