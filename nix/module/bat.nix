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
            rev = "c8ea87cd34b0267c44a67e90ff8f6e7d6af46ff9";
            sha256 = "034mg73lh8d7wg9isdl7kw4yyxaz9wcwmf83kxpfmr5jl7i1r0kl";
          }
          + "/extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
