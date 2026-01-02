return {
  "neovim/nvim-lspconfig",
  event = { "LspAttach", "InsertEnter", "BufWinEnter", "BufNewFile" },
  dependencies = {
    { "saghen/blink.cmp", event = { "InsertEnter", "CmdlineEnter" } },
    { "b0o/schemastore.nvim", event = "InsertEnter" },
    "nvimtools/none-ls.nvim",
    { "williamboman/mason.nvim", cmd = { "Mason", "MasonUpdate" }, enabled = false },
    "nvimtools/none-ls-extras.nvim",
    -- { "yioneko/nvim-vtsls", ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
    {
      "youyoumu/pretty-ts-errors.nvim",
      ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      opts = {
        executable = "/Users/dlvhdr/npm/pretty-ts-errors-markdown",
        auto_open = false,
        max_width = 120,
        max_height = 40,
      },
    },
  },
  config = function()
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
