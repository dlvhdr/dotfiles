return {
  "drybalka/tree-climber.nvim",
  dependecies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    {
      "K",
      function(opts)
        require("tree-climber").goto_parent(opts)
      end,
      mode = { "n", "v", "o" },
    },
    {
      "L",
      function(opts)
        require("tree-climber").goto_next(opts)
      end,
      mode = { "n", "v", "o" },
    },
    {
      "H",
      function(opts)
        require("tree-climber").goto_prev(opts)
      end,
      mode = { "n", "v", "o" },
    },
    {
      "J",
      function(opts)
        require("tree-climber").goto_child(opts)
      end,
      mode = { "n", "v", "o" },
    },
  },
}
