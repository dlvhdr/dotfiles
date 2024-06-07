return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>cR",
      function()
        require("grug-far").grug_far()
      end,
      desc = "Find and replace globally",
      mode = { "n", "x" },
      silent = true,
    },
  },
  config = function()
    require("grug-far").setup({})
  end,
}
