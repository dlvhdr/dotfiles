return {
  "neovim/nvim-lspconfig",
  event = "BufReadPost",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "b0o/schemastore.nvim",
    "nvimtools/none-ls.nvim",
    "williamboman/mason.nvim",
    "nvimtools/none-ls-extras.nvim",
    "yioneko/nvim-vtsls",
  },
  config = function()
    require("dlvhdr.plugins.lsp.handlers").setup()
    require("dlvhdr.plugins.lsp.servers").setup()
    require("lspconfig.ui.windows").default_options.border = "rounded"

    vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart all<CR>", { silent = true, desc = "Restart All Servers" })
    vim.keymap.set("n", "<leader>le", "<cmd>!eslint_d restart<CR>", { silent = true, desc = "Restart eslint_d" })
  end,
}
