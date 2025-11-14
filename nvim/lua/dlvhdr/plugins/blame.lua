return {
  "FabijanZulj/blame.nvim",
  cmd = "BlameToggle",
  keys = {
    { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Git Blame" },
  },
  config = function()
    require("blame").setup({
      max_summary_width = 25,
      mappings = {
        commit_info = "i",
        stack_push = "<TAB>",
        stack_pop = "<BS>",
        show_commit = "<CR>",
        close = { "q" },
      },
      date_format = "%r",
      relative_date_if_recent = true,
    })
  end,
}
