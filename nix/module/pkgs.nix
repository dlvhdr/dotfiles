{ pkgs, ... }:
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
      glow
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
      sd
      stats
      terminal-notifier
      tig
      tldr
      update-nix-fetchgit
      wget
      yarn
      yq-go

      vscode-js-debug

      (google-cloud-sdk.withExtraComponents [
        google-cloud-sdk.components.gke-gcloud-auth-plugin
      ])
      kubectl
      kubectx

      nur.repos.caarlos0.gopls # always latest
      nur.repos.caarlos0.golangci-lint # always latest

      nur.repos.charmbracelet.mods
      nur.repos.charmbracelet.vhs
      nur.repos.caarlos0.svu
    ];
}
