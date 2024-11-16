{ config, ... }:
{
  xdg.configFile."gh-dash" = {
    source = config.lib.file.mkOutOfStoreSymlink ./configs;
  };
}
