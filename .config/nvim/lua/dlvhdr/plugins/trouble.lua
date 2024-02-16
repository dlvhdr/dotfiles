return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "TroubleToggle", "TroubleRefresh", "TroubleClose", "Trouble" },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, desc = "Toggle Trouble" } },
    {
      "<leader>xw",
      "<cmd>Trouble lsp_workspace_diagnostics<cr>",
      { silent = true, desc = "Workspace Diagnostics" },
    },
    { "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, desc = "Document Diagnostics" } },
    { "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, desc = "Loclist" } },
    { "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, desc = "Quickfix" } },
    { "<leader>xr", "<cmd>Trouble lsp_references<cr>", { silent = true, desc = "LSP References" } },
  },
  config = function()
    require("trouble").setup({})
  end,
}
