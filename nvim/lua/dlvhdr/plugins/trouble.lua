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
  init = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>xd", desc = "Document Diagnostics" },
      { "<leader>xl", desc = "Loclist" },
      { "<leader>xq", desc = "Quickfix" },
      { "<leader>xr", desc = "LSP References" },
    })
  end,
  specs = {
    "folke/snacks.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          actions = require("trouble.sources.snacks").actions,
          win = {
            input = {
              keys = {
                ["<c-t>"] = {
                  "trouble_open",
                  mode = { "n", "i" },
                },
              },
            },
          },
        },
      })
    end,
  },
  config = function()
    require("trouble").setup({})
  end,
}
