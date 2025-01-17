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
            rev = "775f82f08a3d1fb55a37fc6d3a4ab10cd7ed8a10";
            sha256 = "0aw4qzh4mj592g08nfb9zbviybq7gj3fgkvzw67q0qaficj2lpyl";
          }
          + "/extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
