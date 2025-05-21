{ config, ... }:
let
  gitPath = "${config.home.homeDirectory}/dotfiles/nix/module/git/config";
in
{
  xdg.configFile."git".source = config.lib.file.mkOutOfStoreSymlink gitPath;
}
