return {
  "linrongbin16/gitlinker.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("gitlinker").setup({})
  end,
  keys = {
    {
      "<leader>gym",
      "<cmd>GitLink default_branch<cr>",
      desc = "Copy line URL (main branch)",
      mode = { "n", "v" },
    },
    {
      "<leader>gyb",
      "<cmd>GitLink current_branch<cr>",
      desc = "Copy line URL (current branch)",
      mode = { "n", "v" },
    },
    {
      "<leader>gyc",
      "<cmd>GitLink<cr>",
      desc = "Copy line URL (commit)",
      mode = { "n", "v" },
    },
    {
      "<leader>gB",
      "<cmd>GitLink! blame_default_branch<cr>",
      desc = "GitHub Blame (main branch)",
      mode = { "v", "n" },
    },
  },
}
