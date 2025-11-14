return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>cR",
      function()
        require("grug-far").open()
      end,
      desc = "Find and replace globally",
      mode = { "n", "x" },
      silent = true,
    },
  },
  config = function()
    require("grug-far").setup({
      resultsSeparatorLineChar = "―",
      openTargetWindow = {
        preferredLocation = "right",
      },
    })
  end,
}
