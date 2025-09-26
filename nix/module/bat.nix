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
            rev = "ca56e536f565293b83a075971fb5880cfe41d6de";
            sha256 = "08bwprzhrdf60ihgihl25ld980qpfx7mh1x0b3kw58d0c0gib87v";
          }
          + "/extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
