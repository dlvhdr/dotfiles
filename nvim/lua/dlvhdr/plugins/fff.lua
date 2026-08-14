return {
  "metziger23/snacks-fff.nvim",
  dependencies = {
    "folke/snacks.nvim",
    {
      "dmtrKovalenko/fff.nvim",
      build = function()
        require("fff.download").download_or_build_binary()
      end,
    },
  },
  config = function()
    require("snacks-fff").setup({})
  end,
  keys = {
    {
      "<C-p>",
      function()
        require("snacks-fff").find_files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        require("snacks-fff").live_grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>*",
      function()
        require("snacks-fff").grep_word()
      end,
      desc = "Grep Word Under Cursor",
    },
  },
}
