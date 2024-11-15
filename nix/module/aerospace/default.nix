{ config, ... }:
{
  xdg.configFile."aerospace/aerospace.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink ./aerospace.toml;
  };
  xdg.configFile."aerospace/default-config.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink ./default-config.toml;
  };
}
