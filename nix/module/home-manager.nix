{ pkgs, ... }:
{
  # add home-manager user settings here
  # generic: neovim, atuin, lazygit, gh, tig, svu, sesh
  # k9s, bpytop, artprint, nixd, nixpkgs-fmt
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
  xdg.enable = true;

  home.packages = with pkgs; [ ];
  programs.neovim.enable = true;
  imports = [
    ./tmux
    ./fish
    ./ghostty
    ./git
    ./starship
    ./yazi
    ./lazygit

    ./pkgs.nix
    ./bat.nix
    ./fzf.nix
    ./zoxide.nix
    ./direnv.nix
  ];
}
