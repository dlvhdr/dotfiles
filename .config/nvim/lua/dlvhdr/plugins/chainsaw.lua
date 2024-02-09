return {
  "chrisgrieser/nvim-chainsaw",
  config = function()
    ---@diagnostic disable: missing-fields
    require("chainsaw").setup({
      marker = "[🪲 dlvhdr]",
    })
  end,
  keys = {
    {
      "<leader>dll",
      function()
        require("chainsaw").messageLog()
      end,
      desc = "Message Log",
    },
    {
      "<leader>dlv",
      function()
        require("chainsaw").variableLog()
      end,
      desc = "Variable Log",
    },
    {
      "<leader>dlb",
      function()
        require("chainsaw").beepLog()
      end,
      desc = "Beep Log",
    },
    {
      "<leader>dlr",
      function()
        require("chainsaw").removeLogs()
      end,
      desc = "Remove Logs",
    },
  },
}
