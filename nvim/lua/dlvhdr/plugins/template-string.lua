return {
  "axelvc/template-string.nvim",
  enabled = false,
  dependencies = {
    "nvim-treesitter",
  },
  event = "InsertEnter",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    require("template-string").setup({})
  end,
}
