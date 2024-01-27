return {
  "chrisgrieser/nvim-chainsaw",
  config = function()
    ---@diagnostic disable: missing-fields
    require("chainsaw").setup({
      marker = "🪲 dlvhdr",
    })
  end,
  keys = {
    {
      "<leader>dll",
      function()
        require("chainsaw").messageLog()
      end,
    },
    {
      "<leader>dlv",
      function()
        require("chainsaw").variableLog()
      end,
    },
    {
      "<leader>dlb",
      function()
        require("chainsaw").beepLog()
      end,
    },
    {
      "<leader>dlr",
      function()
        require("chainsaw").removeLogs()
      end,
    },
  },
}
