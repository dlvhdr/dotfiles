local M = {}

M.setup = function(opts)
  require("lspconfig").nixd.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    cmd = { "nixd" },
    settings = {
      nixd = {
        nixpkgs = {
          expr = "import <nixpkgs> { }",
        },
        formatting = {
          command = { "nixfmt" }, -- or nixfmt or nixpkgs-fmt
        },
        -- options = {
        --   nixos = {
        --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").nixosConfigurations.CONFIGNAME.options',
        --   },
        --   home_manager = {
        --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").homeConfigurations.CONFIGNAME.options',
        --   },
        -- },
      },
    },
  })
end

return M
