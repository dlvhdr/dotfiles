{
  inputs,
  username,
  overlays,
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
    { nixpkgs.overlays = overlays; }
    {
      environment.systemPackages = with pkgs; [
        nixd
        nixfmt-rfc-style
      ];
      services.nix-daemon.enable = true;
      system.stateVersion = 5;

      users.users.${username}.home = "/Users/${username}";
    }

    {
      homebrew = {
        enable = true;
        onActivation.cleanup = "uninstall";

        brews = [
          "atuin"
          "dhth/tap/mult"
          "joshmedeski/sesh/sesh"
        ];

        casks = [
          "1password"
          "betterdisplay"
          "discord"
          "figma"
          "font-commit-mono"
          "font-commit-mono-nerd-font"
          "font-dejavu-sans-mono-nerd-font"
          "font-fira-code-nerd-font"
          "font-symbols-only-nerd-font"
          "google-chrome"
          "hiddenbar"
          "nikitabobko/tap/aerospace"
          "notion-calendar"
          "notunes"
          "obsidian"
          "raycast"
          "slack"
          "stats"
          "th-ch/youtube-music/youtube-music"
          "ticktick"
          "visual-studio-code"
          "whatsapp"
          "zoom"
          "vivaldi"

          # komodor
          "clickup"
          "datagrip"
        ];
      };
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
