#!/usr/bin/env bash

SESSION_WINDOWS=$(tmux list-windows | wc -l)
WINDOW_PANES=$(tmux list-panes -F '#{window_panes}')
SESSION_NAME=$(tmux display-message -p '#S')

if [ "$SESSION_WINDOWS" -eq 1 ] && [ "$WINDOW_PANES" -eq 1 ] ; then
    if [ "$(tmux list-sessions | wc -l)" -ge 2 ]; then
        sesh last
    fi;
    tmux kill-session -t "$SESSION_NAME";
else
    tmux kill-pane;
fi
