function d
  set selected (dirs -p | fzf)
  if -n "$selected"
    cd "$selected" || exit
  end
end

