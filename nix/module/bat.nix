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
            rev = "2642dbb83333e0575d1c3436e1d837926871c5fb";
            sha256 = "0835zvgf1k6xszc4rz5pyb5cz1cyf95vj1q17nx48zz95p4vk0bl";
          }
          + "/extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
