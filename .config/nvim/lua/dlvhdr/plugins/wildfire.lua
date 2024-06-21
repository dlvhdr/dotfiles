-- Incremental and decremental selection
return {
  "sustech-data/wildfire.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("wildfire").setup()
  end,
  enabled = false,
}
