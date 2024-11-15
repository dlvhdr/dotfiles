{ config, ... }:
{
  xdg.configFile."tig/config" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };
}
