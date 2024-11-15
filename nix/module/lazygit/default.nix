{ config, ... }:
{
  programs.lazygit = {
    enable = true;
  };

  xdg.configFile."lazygit/config.yml" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config.yml;
  };
  xdg.configFile."lazygit/edit-nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ./edit-nvim;
  };
}
