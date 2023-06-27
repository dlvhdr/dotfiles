function commit
  set msg (git diff HEAD | mods "create a one line convetional commit message from this git diff")
  git commit -m $msg
end
