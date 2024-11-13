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
            rev = "9758827c3b380ba89da4a2212b6255d01afbcf08";
            sha256 = "sha256-qEmfBs+rKP25RlS7VxNSw9w4GnlZiiEchs17nJg7vsE=";
          }
          + "/extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
