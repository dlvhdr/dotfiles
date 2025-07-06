{ config, ... }:
let
  yaziPath = "${config.home.homeDirectory}/dotfiles/nix/module/yazi/config";
in
{
  programs.yazi = {
    enable = true;

    enableFishIntegration = false;
  };

  xdg.configFile."yazi".source = config.lib.file.mkOutOfStoreSymlink yaziPath;
}
