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
    (callPackage ./arttime { })
    (callPackage ./monocd { })
  ];

  home.file."Library/KeyBindings/DefaultKeyBinding.dict".text = ''
    {
        "^w" = deleteWordBackward:; 
    }
  '';

  imports = [
    ./aerospace
    ./btop
    ./dirs
    ./fish
    ./gh
    ./gh-dash
    ./ghostty
    ./git
    ./k9s
    ./lazygit
    ./lla
    ./npm
    ./nvim
    ./raycast
    ./sesh
    ./starship
    ./tig
    ./tmux
    ./vimium
    ./yazi

    ./pkgs.nix

    ./bat.nix
    ./direnv.nix
    ./fd.nix
    ./fzf.nix
    ./go.nix
    ./zoxide.nix
  ];
}
