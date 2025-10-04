{ pkgs, config, ... }:
{
  programs.fish.interactiveShellInit = ''
    fish_add_path -p ~/code/go/bin
  '';
  programs.go = {
    enable = true;
    package = pkgs.go_1_24;
    env = {
      GOPRIVATE = "github.com/dlvhdr/*";
      GOPATH = "${config.home.homeDirectory}/code/go";
    };
  };
  home.packages = with pkgs; [
    gopls
    golangci-lint
    go-task
  ];
}
