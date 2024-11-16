{ config, ... }:
{
  xdg.configFile."dir_shortener/dirs.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink ./dirs.conf;
  };
}
