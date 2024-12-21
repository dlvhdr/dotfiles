{ config, ... }:
{
  xdg.configFile."lla/config.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config.toml;
  };
}
