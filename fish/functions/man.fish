function man --wraps='man'
  tmux rename-window ' man'
  command man $argv; 
  tmux set-option automatic-rename on
end
