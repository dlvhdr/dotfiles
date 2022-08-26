function cd_repo
  set repos (find ~/code/wix ~/code/personal ~/code/playground -type d  -mindepth 1 -maxdepth 1 | sed "s#$HOME/code/##" | grep -v "DS_Store")

  set selected (gum filter --height 10 --indicator="→" -- $repos)
  
  if test -n "$selected"
    cd "$HOME/code/$selected" || exit
  end
end

