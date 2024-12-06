{
  inputs,
  username,
  overlays,
}:
system:
let
  system-config = import ../module/system-configuration.nix;
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
      environment = {
        etc."pam.d/sudo_local".text = ''
          # Managed by Nix Darwin
          auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
          auth       sufficient     pam_tid.so
        '';
      };
      security.pam.enableSudoTouchIdAuth = true;

      services.nix-daemon.enable = true;
      system.stateVersion = 5;

      security.sudo = {
        extraConfig = ''
          Defaults pwfeedback
          Defaults timestamp_timeout=60
          Defaults timestamp_type=global
        '';
      };

      users.users.${username}.home = "/Users/${username}";
    }

    system-config

    {
      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";

        brews = [
          "atuin"
          "dhth/tap/mult"
          "joshmedeski/sesh/sesh"

          # for neovim
          "sqlite"

          # TODO: move to home-manager
          "charmbracelet/tap/sequin"
          "dlvhdr/formulae/diffnav"
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
          "homerow"
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
          "vivaldi"
          "whatsapp"
          "zoom"

          # komodor
          "clickup"
          "datagrip"
        ];
      };
    }

    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users."${username}" = home-manager-config;
    }
  ];

}
