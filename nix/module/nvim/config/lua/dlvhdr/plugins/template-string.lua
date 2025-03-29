return {
  "axelvc/template-string.nvim",
  dependencies = {
    "nvim-treesitter",
  },
  event = "InsertEnter",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    require("template-string").setup({})
  end,
}
