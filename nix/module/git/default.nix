{ config, lib, ... }:
{
  programs.git = {
    enable = true;

    ignores = lib.splitString "\n" (builtins.readFile ./ignore);
  };

  xdg.configFile."git/config" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };
  xdg.configFile."git/config-komodor" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config-komodor;
  };
  xdg.configFile."git/config-personal" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config-personal;
  };
}
