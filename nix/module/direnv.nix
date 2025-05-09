{ ... }:
{
  programs.direnv = {
    enable = true;
    config = {
      global = {
        log_filter = "^$";
      };
    };
  };
}
