#!/usr/bin/env fish

set --local KITTY_SOCK (fd '^kitty-\d+$' /tmp --max-depth 1 | head -n1)
set --local SESSION (ls $HOME/dotfiles/kitty/sessions | choose -n 20 -f 'CommitMono Nerd Font' -s 20 -u -p 'Session…' -a)

if test $status = 1
  exit 1
end

kitty @ --to "unix:$KITTY_SOCK" action goto_session "$HOME/dotfiles/kitty/sessions/$SESSION"
