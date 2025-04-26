{ pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
  xdg.enable = true;

  home.packages = with pkgs; [
    # custom packages
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
    ./atuin
    ./bins
    ./btop
    ./dirs
    ./fish
    ./gh
    ./gh-dash
    ./ghostty
    ./git
    ./k9s
    ./lazygit
    ./linearmouse
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
