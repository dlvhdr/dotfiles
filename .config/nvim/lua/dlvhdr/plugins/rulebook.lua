return {
  "chrisgrieser/nvim-rulebook",
  keys = {
    {
      "<leader>gi",
      mode = { "n", "x", "o" },
      function()
        require("rulebook").ignoreRule()
      end,
      { desc = "Rulebook ignore" },
    },
    {
      "<leader>gl",
      function()
        require("rulebook").lookupRule()
      end,
      { desc = "Rulebook lookup" },
    },
  },
}
