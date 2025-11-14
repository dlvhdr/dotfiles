return {
  "smjonas/inc-rename.nvim",
  dependencies = { "stevearc/dressing.nvim" },
  cmd = "IncRename",
  config = function()
    require("inc_rename").setup({
      -- input_buffer_type = "dressing",
    })
  end,
  keys = {
    {
      "gR",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      expr = true,
      desc = "Rename",
    },
  },
}
