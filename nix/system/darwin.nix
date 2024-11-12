{
  inputs,
  username,
}:
system:
let
  system-config = import ../module/configuration.nix;
  home-manager-config = import ../module/home-manager.nix;
  pkgs = inputs.nixpkgs.legacyPackages.${system};

in
inputs.darwin.lib.darwinSystem {
  inherit system;

  # modules: allows for reusable code
  modules = [
    {
      environment.systemPackages = with pkgs; [
        nixd
        nixfmt-rfc-style
      ];
      services.nix-daemon.enable = true;
      system.stateVersion = 5;

      users.users.${username}.home = "/Users/${username}";
    }

    system-config

    inputs.home-manager.darwinModules.home-manager
    {
      # add home-manager settings here
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users."${username}" = home-manager-config;
    }
    # add more nix modules here
  ];
}
