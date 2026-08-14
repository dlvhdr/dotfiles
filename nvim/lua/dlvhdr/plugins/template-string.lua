return {
  "axelvc/template-string.nvim",
  event = "InsertEnter",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    require("template-string").setup({})
  end,
}
