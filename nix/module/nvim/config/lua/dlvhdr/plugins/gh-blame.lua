return {
  "dlvhdr/gh-blame.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  keys = {
    { "<leader>gg", "<cmd>GhBlameCurrentLine<cr>", desc = "GitHub Blame Current Line" },
  },
}
