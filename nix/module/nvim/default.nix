{
  pkgs,
  config,
  ...
}:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # gopls - using caarlos0's gopls which is always latest
      # markdownlint
      bash-language-server
      codespell
      delve
      deno # used for peek.nvim
      docker-compose-language-service
      dockerfile-language-server-nodejs
      eslint_d
      gofumpt
      goimports-reviser
      helm-ls
      imagemagick
      lua51Packages.lua
      lua-language-server
      luarocks
      marksman
      prettierd
      shfmt
      stylua
      typescript-language-server
      vscode-js-debug
      vscode-langservers-extracted
      vtsls
      yaml-language-server
    ];

    extraLuaPackages = ps: [ ps.magick ];
  };

  # Need to use the absolute path to my nvim configuration. When using Flakes, your Flake directory is first copied to the Nix store. During evaluation, relative paths are resolved within this store path rather than your home directory. Using an absolute path ensures correct symlinking.
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/Users/dlvhdr/dotfiles/nix/module/nvim/config";

}
