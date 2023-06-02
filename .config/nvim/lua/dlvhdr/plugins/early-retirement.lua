return {
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
    enabled = false,
  },
  {
    "axkirillov/hbac.nvim",
    config = function()
      require("hbac").setup()
    end,
  },
}
