{
  description = "dlvhdr's darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          programs.fish = {
            enable = true;
            interactiveShellInit = ''
              fish_add_path -p ~/.nix-profile/bin /nix/var/nix/profiles/default/bin
            '';
          };

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.vim
            pkgs.neovim
            pkgs.fish
            pkgs.cowsay
            pkgs.nixfmt-rfc-style
            pkgs.nixd
          ];

          nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

          # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;
          # nix.package = pkgs.nix;

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          users.users.dlvhdr = {
            name = "dlvhdr";
            home = "/Users/dlvhdr";
          };
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Dolevs-MacBook-Pro
      darwinConfigurations."Dolevs-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Dolevs-MacBook-Pro".pkgs;
    };
}
