function cds
  cd $(tmux display-message -p -F "#{session_path}")
end
