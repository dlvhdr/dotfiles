#!/opt/homebrew/bin/fish

WINDOWS = (tmux list-windows -F "#{window_name}")
if contains "gh-dash" $WINDOWS
    tmux switch-client -t :gh-dash
    exit 0
end

set SESS_PATH (tmux display-message -p -F "#{session_path}")
tmux new-window -S -n gh-dash "FF_REPO_VIEW= gh dash $SESS_PATH" 
tmux switch-client -t :gh-dash

tmux set-option -p -t 1 pane-border-format '#{?pane_active,#[fg=green],#[fg=#63697F]} gh-dash#{?window_zoomed_flag, #[fg=white]#{pane_index}/#{window_panes} ,} '

# set NUM_PANES (tmux display-message -p -F "#{window_panes}")
# if test $NUM_PANES -eq 2
#     exit 0
# end

# tmux splitw -h -v "lazygit -p $SESS_PATH"
#  pane-border-format "lazygit"
#
# tmux set-option -p -t 2 pane-border-format '#{?pane_active,#[fg=green],#[fg=#63697F]}lazygit#{?window_zoomed_flag, #[fg=white]#{pane_index}/#{window_panes} ,} '
