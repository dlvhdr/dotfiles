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
      ripgrep
      fd
      eza
      tldr
      curl
      curlie
      entr
      sd
      hyperfine
      glow
      dust
      jnv
      fx
      jqp
      clipboard-jh
      gum
    ];
}
