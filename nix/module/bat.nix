{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "tokyonight_night";
      paging = "auto";
    };
    themes = {
      tokyonight_night = {
        src =
          pkgs.fetchFromGitHub {
            owner = "folke";
            repo = "tokyonight.nvim";
            rev = "4d159616aee17796c2c94d2f5f87d2ee1a3f67c7";
            sha256 = "1bpki7gglch1n77kcrnyabmz7r41d6b6yq5fa70w4pxwp7y62d6h";
          }
          + "/extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
