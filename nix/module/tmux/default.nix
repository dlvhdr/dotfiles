{
  pkgs,
  config,
  lib,
  ...
}:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  mkOrder = lib.mkOrder;

  nerd-font-window-name = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "nerd-font-window-name";
    version = "v2.1.2";
    rtpFilePath = "tmux-nerd-font-window-name.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "tmux-nerd-font-window-name";
      rev = "v2.1.2";
      hash = "sha256-bnlOAfdBv5Rg4z1hu1jtdx5oZ6kAZE40K4zqLxmyYQE=";
    };
  };

  fzf-url = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "fzf-url";
    version = "3bc7b34c0321d5dfe4a8d2545be23654ad321fc0";
    rtpFilePath = "fzf-url.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "tmux-fzf-url";
      rev = "3bc7b34c0321d5dfe4a8d2545be23654ad321fc0";
      hash = "sha256-aWqwoJ5L3FB6vZKds7Q4AQ/8Pv2zQnPugL/6BpsBlRo=";
    };
  };

  last = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "last";
    version = "4d7e0c1386a9a74803a53b524ac47dd3cd08c0a4";
    rtpFilePath = "tmux-last.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "mskelton";
      repo = "tmux-last";
      rev = "4d7e0c1386a9a74803a53b524ac47dd3cd08c0a4";
      hash = "sha256-ydWdL2bdHb58F+i1+nwfRqI9T85ez1Cw6YAZIgz/2V4=";
    };
  };
in
{
  xdg.configFile."tmux/gitmux.yml".source = mkOutOfStoreSymlink ./gitmux.yml;
  xdg.configFile."tmux/kill.sh".source = mkOutOfStoreSymlink ./kill.sh;
  xdg.configFile."tmux/open-dotfiles.fish".source = mkOutOfStoreSymlink ./open-dotfiles.fish;
  xdg.configFile."tmux/open-lazygit.fish".source = mkOutOfStoreSymlink ./open-lazygit.fish;
  xdg.configFile."tmux/tmux-nerd-font-window-name.yml".source =
    mkOutOfStoreSymlink ./tmux-nerd-font-window-name.yml;
  xdg.configFile."tmux/tmux.reset.conf".source = mkOutOfStoreSymlink ./tmux.reset.conf;
  programs = {
    fish = {
      shellInit = ''
        fish_add_path ${nerd-font-window-name}/share/tmux-plugins/nerd-font-window-name/bin
      '';
    };
    tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator

        {
          plugin = tmuxPlugins.better-mouse-mode;
          extraConfig = ''
            set -g @emulate-scroll-for-no-mouse-alternate-buffer "on"
          '';
        }

        {
          plugin = tmuxPlugins.fingers;
          extraConfig = ''
            set -g @fingers-hint-style 'fg=colour0,bg=colour3'
          '';
        }

        {
          plugin = nerd-font-window-name;
          extraConfig = ''
            set -g pane-border-format '#{?pane_active,#[fg=green],#[fg=#63697F]}#(${nerd-font-window-name}/share/tmux-plugins/nerd-font-window-name/bin/tmux-nerd-font-window-name #{pane_current_command} #{window_panes})#{?window_zoomed_flag, #[fg=white]#{pane_index}/#{window_panes} ,} '
          '';
        }

        {
          plugin = fzf-url;
          extraConfig = ''
            set -g @fzf-url-fzf-options '-p 60%,30% --prompt="  " --border-label=" Open URL "'
            set -g @fzf-url-history-limit '2000'
          '';
        }

        {
          plugin = last;
          extraConfig = ''
            set -g @tmux-last-prompt-pattern '󱝁 '
            set -g @tmux-last-key C
            set -g @tmux-last-prompt-lines 2
            set -g @tmux-last-pager "less +g -~ -r"
            set -g @tmux-last-color on
          '';
        }

        # set -g @plugin 'RyanMillerC/better-vim-tmux-resizer'
      ];
    };
  };
  xdg.configFile."tmux/tmux.conf".text = mkOrder 600 (builtins.readFile ./tmux.conf);
}
