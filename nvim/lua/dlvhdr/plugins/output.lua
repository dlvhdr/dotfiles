return {
  "mhanberg/output-panel.nvim",
  event = "VeryLazy",
  enabled = false,
  cmd = "OutputPanel",
  config = function()
    require("output_panel").setup()
  end,
}
