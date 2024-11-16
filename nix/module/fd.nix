{ ... }:
{
  programs.fd = {
    enable = true;
    ignores = [
      ".git/"
      "node_modules/"
    ];
    hidden = true;
  };

}
