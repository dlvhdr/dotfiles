return {
  "Chaitanyabsprip/fastaction.nvim",
  dependencies = "folke/which-key.nvim",
  Event = "LspAttach",
  init = function()
    local wk = require("which-key")
    wk.add({
      { "ga", group = "Code Action" },
    })
  end,
  config = function()
    require("fastaction").setup({})

    vim.keymap.set(
      { "n", "x" },
      "ga",
      '<cmd>lua require("fastaction").code_action()<CR>',
      { desc = "Display code actions" }
    )
  end,
}
