function fish_user_key_bindings
  fish_default_key_bindings -M insert
  fish_vi_key_bindings --no-erase insert
  bind --preset -M command \cp up-or-search
  bind -s --preset -M visual -m default y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
end

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block
set -g fish_vi_force_cursor 1

bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste
