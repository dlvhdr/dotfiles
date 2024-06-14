#!/opt/homebrew/bin/fish

set windows (tmux list-windows -F '#{pane_tty} #{window_index} #{pane_current_command} #{window_name}')
for window in $windows
  set -l vars (string split " " $window)
  set tty $vars[1]
  set index $vars[2]
  set pane_command $vars[3]
set window_name $vars[4]

  # set window_name (/Users/dlvhdr/.config/tmux/tty2procname $tty)
  if string match -q "lazygit" $pane_command
    tmux switch-client -t ":$index"
    return
  end

  if string match -q "lazygit" $window_name
    tmux switch-client -t ":$window_name"
    tmux send-keys -t ":lazygit" "lazygit" Enter;
    return
  end
end

tmux neww -n "lazygit"
tmux send-keys -t ":lazygit" "lazygit" Enter;
