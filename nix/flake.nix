{
  description = "dlvhdr's Nix on macOS environment.";

  # define where to get packages from
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    # nix modules for macOS such as homebrew, launchd, users, networking etc.
    # It's like NixOS for macOS. (?)
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Manage user configuration with Nix like linking dotfiles, installing packages etc.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # modules published by charm like mods and vhs
    charmbracelet-nur.url = "github:charmbracelet/nur";

    # gh-dash.url = "git+file:/Users/dlvhdr/code/personal/gh-dash?shallow=1";

    # Weekly updated nix-index database
    # Not sure why I need this.
    # nixos-unstable seems to be updated on every commit essentially unless there are delays.
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nur,
      charmbracelet-nur,
      nix-index-database,
      ...
    }:
    let
      # overlays allow extending and changing nixpkgs with custom packages
      overlays = [
        (final: prev: {
          nur = import nur {
            nurpkgs = prev;
            pkgs = prev;
            # add caarlos0 and charmbracelet modules to nixpkgs
            repoOverrides = {
              charmbracelet = import charmbracelet-nur { pkgs = prev; };
            };
          };
        })
      ];

      username = "dlvhdr";

      # configuration for macOS
      darwin-system = import ./system/darwin.nix {
        inherit
          inputs
          username
          overlays
          nix-index-database
          # gh-dash
          ;
      };
    in
    {
      # don't create man pages caches and it takes a long time to build
      documentation.man.generateCaches = false;

      darwinConfigurations = {
        aarch64 = darwin-system "aarch64-darwin";
      };
    };
}
