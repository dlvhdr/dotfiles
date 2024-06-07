return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "Trouble" },
  keys = {
    { "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, desc = "Document Diagnostics" } },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { silent = true, desc = "Loclist" } },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { silent = true, desc = "Quickfix" } },
    { "<leader>xr", "<cmd>Trouble lsp toggle focus=false<cr>", { silent = true, desc = "LSP References" } },
  },
  config = function()
    require("trouble").setup({})
  end,
}
