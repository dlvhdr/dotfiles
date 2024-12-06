{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };

  home.packages = with pkgs; [
    codespell
    imagemagick
    lua51Packages.lua
    lua51Packages.luarocks
    stylua
  ];
}
