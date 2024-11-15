{ ... }:
{
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      editor = "nvim";
      prompt = "enabled";
      pager = "";
      http_unix_socket = "";
      browser = "";
      version = "1";
      aliases = {
        co = "pr checkout";
        vpr = "pr view --web";
        vr = "repo view --web";
        clean-branches = "poi";
      };
    };
  };
}
