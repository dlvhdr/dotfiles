return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  keys = {
    { "<leader>tn", ":TestNearest<CR>", desc = "Test Nearest" },
    { "<leader>tf", ":TestFile<CR>", desc = "Test File" },
    { "<leader>ts", ":TestSuite<CR>", desc = "Test Suite" },
    { "<leader>tl", ":TestLast<CR>", desc = "Test Last" },
    { "<leader>tg", ":TestVisit<CR>", desc = "Visit Test" },
  },
  config = function()
    vim.cmd("let test#strategy = 'vimux'")
  end,
}
