{ pkgs, ... }:
{
  # add home-manager user settings here
  # generic: neovim, atuin, arttime/artprint,
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
  xdg.enable = true;

  home.packages = with pkgs; [
    # custom packages
    (callPackage ../bins { })
  ];

  home.file."Library/KeyBindings/DefaultKeyBinding.dict".text = ''
    {
        "^w" = deleteWordBackward:; 
    }
  '';

  imports = [
    ./tmux
    ./fish
    ./ghostty
    ./git
    ./starship
    ./yazi
    ./lazygit
    ./gh
    ./tig
    ./k9s
    ./nvim

    ./pkgs.nix
    ./bat.nix
    ./fzf.nix
    ./zoxide.nix
    ./direnv.nix
  ];
}
