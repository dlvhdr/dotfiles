return {
  "neovim/nvim-lspconfig",
  name = "lsp",
  event = "BufReadPost",
  dependencies = {
    "folke/neodev.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "b0o/schemastore.nvim",
    "nvimtools/none-ls.nvim",
    "williamboman/mason.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    require("dlvhdr.plugins.lsp.handlers").setup()
    require("dlvhdr.plugins.lsp.servers").setup()
    require("lspconfig.ui.windows").default_options.border = "rounded"

    vim.keymap.set("n", "<leader>cl", "<cmd>LspRestart all<CR>", { silent = true, desc = "[LSP] Restart" })
    vim.keymap.set("n", "<leader>cE", "<cmd>!eslint_d restart<CR>", { silent = true, desc = "[LSP] Restart eslint_d" })
  end,
}
