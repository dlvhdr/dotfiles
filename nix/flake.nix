{
  description = "Example kickstart Nix on macOS environment.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caarlos0-nur.url = "github:caarlos0/nur";
    charmbracelet-nur.url = "github:charmbracelet/nur";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nur,
      caarlos0-nur,
      charmbracelet-nur,
      nixpkgs,
      ...
    }:
    let
      overlays = [
        (final: prev: {
          nur = import nur {
            nurpkgs = prev;
            pkgs = prev;
            repoOverrides = {
              caarlos0 = import caarlos0-nur { pkgs = prev; };
              charmbracelet = import charmbracelet-nur { pkgs = prev; };
            };
          };
        })
      ];

      darwin-system = import ./system/darwin.nix { inherit inputs username overlays; };
      username = "dlvhdr";
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix;

      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          overlays = overlays;
        }
      );
    in
    {
      darwinConfigurations = {
        aarch64 = darwin-system "aarch64-darwin";
        x86_64 = darwin-system "x86_64-darwin";
      };

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            buildInputs =
              with pkgs;
              [
              ];
          };
        }
      );
    };
}
