{ config, ... }:
{
  xdg.configFile."raycast/backups" = {
    source = config.lib.file.mkOutOfStoreSymlink ./backups;
  };
  xdg.configFile."raycast/scripts" = {
    source = config.lib.file.mkOutOfStoreSymlink ./scripts;
  };
}
