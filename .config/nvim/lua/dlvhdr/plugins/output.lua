return {
  "mhanberg/output-panel.nvim",
  event = "VeryLazy",
  cmd = "OutputPanel",
  config = function()
    require("output_panel").setup()
  end,
}
