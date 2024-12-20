{ ... }:
{
  programs.atuin = {
    enable = true;

    enableFishIntegration = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      dialect = "uk";
      style = "compact";
      invert = true;
      show_help = false;
      inline_height = 16;
      scroll_context_lines = 3;
      keymap_cursor = {
        emacs = "blink-bar";
        vim_insert = "blink-bar";
        vim_normal = "blink-block";
      };
    };
  };
}
