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
            rev = "45d22cf0e1b93476d3b6d362d720412b3d34465c";
            sha256 = "1038ff6i8csxx3cqccgbpv06slvbcs534cfkq7s58ww2vvldm7sc";
          }
          + "/extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
