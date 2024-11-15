return {
  "axelvc/template-string.nvim",
  dependencies = {
    "nvim-treesitter",
  },
  event = "InsertEnter",
  config = function()
    require("template-string").setup({})
  end,
}
