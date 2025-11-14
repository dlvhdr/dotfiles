return {
  "gregorias/toggle.nvim",
  dependencies = { "folke/which-key.nvim" },
  version = "1.0",
  event = "VeryLazy",
  config = function()
    ---@diagnostic disable: missing-fields
    require("toggle").setup({
      keymaps = {
        toggle_option_prefix = "<leader>u",
        status_dashboard = "<leader>us",
      },
    })
    local wk = require("which-key")
    wk.add({
      { "<leader>u", group = "Toggle", icon = "󰨚 " },
    })
  end,
}
