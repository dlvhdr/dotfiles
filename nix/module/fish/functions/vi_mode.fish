function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
    
    # Emulates vim's cursor shape behavior
    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block
    # set the insert mode cursor to a line
    set fish_cursor_insert line
    # set the replace mode cursor to an underscore
    set fish_cursor_replace_one underscore
    # the following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block

    # prevent fish from appending &| less; to the command when accidentally pressing ctrl+p quickly 
    bind --preset --erase \ep
    bind --preset -M visual --erase \ep
    bind --preset -M insert --erase \ep
end
