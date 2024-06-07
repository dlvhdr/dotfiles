return {
  "luckasRanarison/clear-action.nvim",
  Event = "LspAttach",
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
