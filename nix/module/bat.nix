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
            rev = "057ef5d260c1931f1dffd0f052c685dcd14100a3";
            sha256 = "002rzmdxq45bdyd27i8k8lhdcwxn9l4v6x5cm6g7v1213m0n25np";
          }
          + "/extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
