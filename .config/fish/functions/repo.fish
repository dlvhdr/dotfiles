function repo
  set repos (find ~/code/komodor ~/code/personal ~/code/playground -type d  -mindepth 1 -maxdepth 1 | sed "s#$HOME/code/##" | grep -v "DS_Store")

  set selected (echo $repos | string split -n " " | gum filter --height 10 --indicator="→")
  
  if test -n "$selected"
    cd "$HOME/code/$selected" || exit
  end
end

