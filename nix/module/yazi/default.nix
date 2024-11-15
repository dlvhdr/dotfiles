{ config, ... }:
{
  programs.yazi = {
    enable = true;

    enableFishIntegration = true;
  };

  xdg.configFile."yazi/theme.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink ./theme.toml;
  };
  xdg.configFile."yazi/yazi.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink ./yazi.toml;
  };
}