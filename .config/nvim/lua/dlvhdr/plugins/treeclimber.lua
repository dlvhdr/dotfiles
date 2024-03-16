return {
  "drybalka/tree-climber.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    {
      "K",
      function(opts)
        require("tree-climber").goto_parent(opts)
      end,
      mode = { "n", "o" },
    },
    {
      "L",
      function(opts)
        require("tree-climber").goto_next(opts)
      end,
      mode = { "n", "o" },
    },
    {
      "H",
      function(opts)
        require("tree-climber").goto_prev(opts)
      end,
      mode = { "n", "o" },
    },
    {
      "J",
      function(opts)
        require("tree-climber").goto_child(opts)
      end,
      mode = { "n", "o" },
    },
  },
}
