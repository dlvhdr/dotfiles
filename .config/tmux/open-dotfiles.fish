#!/opt/homebrew/bin/fish

if not tmux has-session -t dotfiles 2>/dev/null;
  tmux new-session -d -s dotfiles -c "$HOME/dotfiles"
end

set windows (tmux list-windows -t dotfiles -F '#{pane_tty} #{window_index}')
for window in $windows
  set -l vars (string split " " $window)
  set tty $vars[1]
  set index $vars[2]

  set window_name (/Users/dlvhdr/.config/tmux/tty2procname $tty)
  if string match -q "nvim" $window_name
    tmux switch-client -t "dotfiles:$index"
    return
  end
end

tmux switch-client -t dotfiles
tmux neww
tmux send-keys -t dotfiles "cd $HOME/dotfiles && nvim +SmartOpen" Enter;
