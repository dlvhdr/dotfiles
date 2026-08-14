#!/bin/bash
set -e
current_workspace=$(aerospace list-workspaces --focused)
win_list=$(aerospace list-windows --all | grep -E "(late.sh — YouTube)" | awk '{print $1}')

echo "$win_list" | while IFS= read -r number; do
  echo "Processing number: $number"
  aerospace move-node-to-workspace --window-id "$number" "$current_workspace" </dev/null
  echo "continue"
done
