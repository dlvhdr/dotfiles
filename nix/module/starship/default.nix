{ config, ... }:
{
  programs.starship = {
    enable = true;

    enableFishIntegration = true;
  };

  xdg.configFile."starship.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink ./starship.toml;
  };
}
