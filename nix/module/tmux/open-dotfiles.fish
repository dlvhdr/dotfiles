#!/usr/bin/env fish

if not tmux has-session -t dotfiles 2>/dev/null;
  tmux new-session -d -s dotfiles -c "$HOME/dotfiles"
end

set windows (tmux list-windows -t dotfiles -F '#{window_index}/#{window_name}')
for window in $windows
  set -l vars (string split --max 2 "/" $window)
  set index $vars[1]
  set window_name $vars[2]

  if string match -q "*nvim*" $window_name
    tmux switch-client -t "dotfiles:$index"
    return
  end
end

tmux switch-client -t dotfiles
tmux neww
tmux send-keys -t dotfiles "cd $HOME/dotfiles && nvim +SmartOpen" Enter;
