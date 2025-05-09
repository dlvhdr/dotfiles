{ config, ... }:
let
  ghDashPath = "${config.home.homeDirectory}/dotfiles/nix/module/gh-dash/config";
in
{
  xdg.configFile."gh-dash".source = config.lib.file.mkOutOfStoreSymlink ghDashPath;
}
