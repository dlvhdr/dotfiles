{ config, ... }:
{
  xdg.configFile."npm/config" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };
}
