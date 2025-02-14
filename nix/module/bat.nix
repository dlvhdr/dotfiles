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
            rev = "84ea0b5f4651afdf50ececaf6f110fe9d9dc9458";
            sha256 = "1w2bv7dcwhgjs38md50ncm0l9vkkg5wd9i47lwdf55x1sasn54hh";
          }
          + "/extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
