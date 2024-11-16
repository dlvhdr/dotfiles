{ config, ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      rounded_corners = true;
      color_theme = "tokyonight";
    };
  };

  xdg.configFile."btop/themes/tokyonight.theme" = {
    source = config.lib.file.mkOutOfStoreSymlink ./tokyonight.theme;
  };
}
