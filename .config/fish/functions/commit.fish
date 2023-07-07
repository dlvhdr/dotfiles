function commit
  set msg (git diff HEAD -- . !yarn.lock | mods "create a one line convetional commit message from this git diff")
  git commit -m $msg
end
