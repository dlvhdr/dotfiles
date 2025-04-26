{ pkgs, ... }:
{
  programs.fish.interactiveShellInit = ''
    fish_add_path -p ~/code/go/bin
  '';
  programs.go = {
    enable = true;
    package = pkgs.go_1_22;
    goPath = "code/go";
  };
  home.packages = with pkgs; [
    gopls
    golangci-lint
    go-task
  ];
}
