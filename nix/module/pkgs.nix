{ pkgs, ... }:
let
  mdfried = builtins.getFlake "github:benjajaja/mdfried/d552cbaa4ba6b73091871b549fbc5b39552ec95f";
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  home.packages =
    with pkgs;
    with pkgs.nodePackages_latest;
    [
      # harlequin
      # python312Packages.harlequin-postgres
      awscli
      clipboard-jh
      curl
      curlie
      delta
      dust
      entr
      eza
      fd
      figlet
      fx
      git-credential-manager
      gitleaks
      gitmux
      glow
      gnupg
      gofumpt
      gojq
      goreleaser
      graphviz
      gum
      hyperfine
      jnv
      jq
      jqp
      kind
      less
      lla
      lolcat
      nixd
      nixfmt-rfc-style
      nodejs
      npkill
      onefetch
      process-compose
      procs
      ripgrep
      rsbkb
      sd
      stats
      terminal-notifier
      tig
      tldr
      tuptime
      update-nix-fetchgit
      uv
      watch
      wget
      yarn
      yq-go

      vscode-js-debug

      (google-cloud-sdk.withExtraComponents [
        google-cloud-sdk.components.gke-gcloud-auth-plugin
      ])
      kubectl
      kubectx
      lnav

      # nur.repos.caarlos0.gopls # always latest
      # nur.repos.caarlos0.golangci-lint # always latest
      # nur.repos.caarlos0.svu
      #
      # nur.repos.charmbracelet.mods
      # nur.repos.charmbracelet.vhs
      mdfried.packages.${pkgs.system}.default
    ];
}
