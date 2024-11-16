{ config, ... }:
{
  xdg.configFile."vimium/vimium-options.json" = {
    source = config.lib.file.mkOutOfStoreSymlink ./vimium-options.json;
  };
}
