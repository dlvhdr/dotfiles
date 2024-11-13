function update
  set cmds "b" "npm update -g --fetch-timeout 3000" "yarn global upgrade" "gh extensions upgrade --all" "go-global-update" "rustup update" "tpmu # update tmux plugins" "nvim --headless \"+Lazy! sync\" +qa"
  set chose (gum choose --no-limit $cmds)
  for cmd in $chose
    eval "$cmd"
  end
end
