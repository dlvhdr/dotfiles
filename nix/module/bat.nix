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
            rev = "5da1b76e64daf4c5d410f06bcb6b9cb640da7dfd";
            sha256 = "1s8qh9a8yajlfybcsky6rb31f0ihfhapm51531zn4xd0fyzy8dz3";
          }
          + "/extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
