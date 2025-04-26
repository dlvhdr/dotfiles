#!/bin/bash
tmux list-sessions -F '#{session_last_attached} #{session_name}' | \
  grep --invert-match "$(tmux display-message -p '#S')" | \
  sort --numeric-sort --reverse | \
  cut -d' ' -f2 | \
  gum filter \
    --indicator="→" \
    --prompt=" " \
    --height="15" \
    --placeholder="Session name..."

