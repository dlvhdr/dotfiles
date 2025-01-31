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
            rev = "dca4adba7dc5f09302a00b0e76078d54d82d2658";
            sha256 = "0l7s7jq555cc5x1ixy91d6xmf7mbcnarkjk17kdqjb3d6cxvdfsq";
          }
          + "/extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
