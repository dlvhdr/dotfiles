{ pkgs, ... }:
{
  # add home-manager user settings here
  # generic: tmux, ghostty, fzf, neovim, git, ripgrep, fd, bat, eza, starship
  # atuin, clipboard, zoxide, yazi, gum, direnv, tldr, lazygit, gh, tig, svu, sesh
  # k9s, bpytop, artprint, curlie, entr, procs, sd, hyperfine, glow, dust, jnv, fx
  # jqp, nixd, nixpkgs-fmt
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
  xdg.enable = true;

  home.packages = with pkgs; [ ];
  programs.neovim.enable = true;
  imports = [
    ./tmux
  ];
}
