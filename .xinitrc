#!/bin/sh
xrandr --output DP-3 --primary &
xrandr --output HDMI-0 --auto --left-of DP-3 &
xsetroot -cursor_name left_ptr &
exec xmonad
