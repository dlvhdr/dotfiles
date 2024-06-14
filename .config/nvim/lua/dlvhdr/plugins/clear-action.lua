return {
  "luckasRanarison/clear-action.nvim",
  dependencies = "folke/which-key.nvim",
  Event = "LspAttach",
  init = function()
    local wk = require("which-key")
    wk.register({
      ["ga"] = {
        name = "Code Action",
      },
    })
  end,
  config = function()
    require("clear-action").setup({
      signs = {
        enable = false,
        position = "right_align",
        separator = " ",
        icons = {
          quickfix = " ",
          refactor = "󰁨 ",
          source = " ",
          combined = "󱉔 ",
        },
        highlights = {
          quickfix = "DiagnosticInfo",
          refactor = "DiagnosticInfo",
          source = "DiagnosticInfo",
          combined = "DiagnosticInfo",
          label = "DiagnosticInfo",
        },
      },
      mappings = {
        code_action = "ga",
      },
    })
  end,
}
