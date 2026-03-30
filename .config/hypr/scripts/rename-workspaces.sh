#!/bin/bash
# Rename DP-2's workspaces (11-20) to display as 1-10
# Delay to ensure hyprsplit has created all workspaces before renaming
sleep 2
for i in $(seq 1 10); do
    hyprctl dispatch renameworkspace $((i + 10)) "$i"
done
