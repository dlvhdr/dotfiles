{ config, ... }:
let
  starshipPath = "${config.home.homeDirectory}/dotfiles/nix/module/starship/config/starship.toml";
in
{
  programs.starship = {
    enable = true;

    enableFishIntegration = true;
  };

  xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink starshipPath;
}
