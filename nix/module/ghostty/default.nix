{ config, ... }:
let
  ghosttyPath = "${config.home.homeDirectory}/dotfiles/nix/module/ghostty/config";
in
{
  xdg.configFile."ghostty".source = config.lib.file.mkOutOfStoreSymlink ghosttyPath;
}
