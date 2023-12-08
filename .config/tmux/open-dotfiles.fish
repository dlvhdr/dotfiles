#!/opt/homebrew/bin/fish

if not tmux has-session -t dotfiles 2>/dev/null;
  tmux new-session -d -s dotfiles -c '$HOME/dotfiles'
end

tmux switch-client -t dotfiles;
tmux send-keys -t dotfiles 'cd $HOME/dotfiles && ./.t' Enter;
