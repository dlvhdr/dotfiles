return {
  "LunarVim/bigfile.nvim",
  event = "BufReadPre",
  config = function()
    ---@diagnostic disable: missing-fields
    require("bigfile").setup({
      filesize = 1,
      pattern = { "*" },
      features = { -- features to disable
        "indent_blankline",
        "illuminate",
        "matchparen",
        "vimopts",
        -- "lsp",
        -- "treesitter",
        -- "syntax",
        -- "filetype",
      },
    })
  end,
}
