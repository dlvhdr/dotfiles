function update
  set cmds "brew update && brew upgrade" "brew upgrade --cask --greedy" "npm update -g --fetch-timeout 3000" "yarn global upgrade" "gh extensions upgrade --all" "gup update" "rustup update"
  set chose (gum choose --no-limit $cmds)
  for cmd in $chose
    eval "$cmd"
  end
end
