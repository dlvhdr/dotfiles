{ config, ... }:
let
  aerospacePath = "${config.home.homeDirectory}/dotfiles/nix/module/aerospace/config";
in
{
  xdg.configFile."aerospace".source = config.lib.file.mkOutOfStoreSymlink aerospacePath;
}
