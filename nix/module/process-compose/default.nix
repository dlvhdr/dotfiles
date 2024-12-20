{ config, ... }:
{
  xdg.configFile."process-compose/shortcuts.yaml" = {
    source = config.lib.file.mkOutOfStoreSymlink ./shortcuts.yaml;
  };
}
