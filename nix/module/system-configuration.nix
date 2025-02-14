{
  username,
  pkgs,
# gh-dash,
}:
{
  environment = {
    etc."pam.d/sudo_local".text = ''
      # Managed by Nix Darwin
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
      auth       sufficient     pam_tid.so
    '';
    # systemPackages = [
    #   gh-dash.packages.aarch64-darwin.default
    # ];
  };
  security.pam.enableSudoTouchIdAuth = true;

  system.stateVersion = 5;

  security.sudo = {
    extraConfig = ''
      Defaults pwfeedback
      Defaults timestamp_timeout=60
      Defaults timestamp_type=global
    '';
  };

  users.users.${username}.home = "/Users/${username}";

  nix = {
    optimise = {
      automatic = true;
    };
    settings = {
      builders-use-substitutes = true;
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [
        "@wheel"
        "dlvhdr"
      ];
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
  };

}
