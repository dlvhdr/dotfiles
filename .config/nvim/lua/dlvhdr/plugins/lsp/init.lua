return {
  "neovim/nvim-lspconfig",
  name = "lsp",
  event = "BufReadPre",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "b0o/schemastore.nvim",
    "folke/neodev.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  },
  config = function()
    require("dlvhdr.plugins.lsp.handlers").setup()
    require("dlvhdr.plugins.lsp.servers")
    require("lspconfig.ui.windows").default_options.border = "rounded"
  end,
}
