function git --wraps='git'
  if test (count $argv) -gt 0
      command git $argv
  else
      command git status
  end
end
