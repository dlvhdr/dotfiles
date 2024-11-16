{ config, ... }:
{
  xdg.configFile."sesh/sesh.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink ./sesh.toml;
  };
}
