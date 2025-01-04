return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  dependencies = {
    { "saghen/blink.cmp", event = "InsertEnter" },
    -- { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
    { "b0o/schemastore.nvim", event = "InsertEnter" },
    "nvimtools/none-ls.nvim",
    { "williamboman/mason.nvim", cmd = { "Mason", "MasonUpdate" }, enabled = false },
    "nvimtools/none-ls-extras.nvim",
    { "yioneko/nvim-vtsls", ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
  },
  config = function()
    require("dlvhdr.plugins.lsp.handlers").setup()
    require("dlvhdr.plugins.lsp.servers").setup()
    require("lspconfig.ui.windows").default_options.border = "rounded"

    vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart all<CR>", { silent = true, desc = "Restart All Servers" })
    vim.keymap.set(
      "n",
      "<leader>le",
      "<cmd>!~/.local/share/nvim/mason/bin/eslint_d --restart<CR>",
      { silent = true, desc = "Restart eslint_d" }
    )
  end,
}
