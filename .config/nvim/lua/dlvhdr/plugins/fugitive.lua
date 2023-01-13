return {
  "tpope/vim-fugitive",
  cmd = "Git",
  keys = {
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame" },
    { "<leader>go", "<cmd>Git browse<cr>", desc = "Browse" },
  },
}
