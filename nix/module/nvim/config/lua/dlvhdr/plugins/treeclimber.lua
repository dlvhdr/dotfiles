local opts = {
  skip_comments = true,
  highlight = true,
  higroup = "IlluminatedWord",
}
return {
  "drybalka/tree-climber.nvim",
  enabled = false,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    {
      "K",
      function()
        require("tree-climber").goto_parent(opts)
      end,
      mode = { "n", "o" },
    },
    {
      "L",
      function()
        require("tree-climber").goto_next(opts)
      end,
      mode = { "n", "o" },
    },
    {
      "H",
      function()
        require("tree-climber").goto_prev(opts)
      end,
      mode = { "n", "o" },
    },
    {
      "J",
      function()
        require("tree-climber").goto_child(opts)
      end,
      mode = { "n", "o" },
    },
  },
}
