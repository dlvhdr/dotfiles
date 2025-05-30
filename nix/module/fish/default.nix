{
  pkgs,
  config,
  ...
}:
{
  programs = {
    fish = {
      enable = true;
      loginShellInit = builtins.readFile ./config.fish;
      interactiveShellInit = ''
        fish_add_path "/Users/dlvhdr/.local/share/../bin"
        fish_add_path -p /etc/profiles/per-user/dlvhdr/bin
        source $XDG_CONFIG_HOME/fish/themes/fish_tokyonight_storm.fish
        atuin init fish --disable-up-arrow | source

        function fish_user_key_bindings
          fish_default_key_bindings -M insert
          fish_vi_key_bindings --no-erase insert
          bind --preset -M command ctrl-p up-or-search
          bind --preset -M command ctrl-n down-or-search
          bind --preset -M insert ctrl-n down-or-search
          bind -s --preset -M visual -m default y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
          bind --preset --erase \ep
          bind --preset -M visual --erase \ep
          bind --preset -M insert --erase \ep
        end

        set fish_cursor_default block
        set fish_cursor_insert line
        set fish_cursor_replace_one underscore
        set fish_cursor_visual block
        set -g fish_vi_force_cursor 1

        bind yy fish_clipboard_copy
        bind Y fish_clipboard_copy
        bind p fish_clipboard_paste

        set __done_notification_command 'terminal-notifier -title \\\$title -message \\\$message'
      '';
      plugins = [
        {
          name = "done";
          inherit (pkgs.fishPlugins.done) src;
        }
      ];
    };
  };

  xdg.configFile."fish/functions" = {
    source = config.lib.file.mkOutOfStoreSymlink ./functions;
  };
  xdg.configFile."fish/themes/fish_tokyonight_storm.fish" = {
    source = ./themes/fish_tokyonight_storm.fish;
  };
}
