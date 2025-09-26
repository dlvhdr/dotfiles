{ pkgs, ... }:
{
  programs.fish.interactiveShellInit = ''
    fish_add_path -p ~/code/go/bin
  '';
  programs.go = {
    enable = true;
    package = pkgs.go_1_24;
    env = {
      GOPATH = "code/go";
    };
  };
  home.packages = with pkgs; [
    gopls
    golangci-lint
    go-task
  ];
}
