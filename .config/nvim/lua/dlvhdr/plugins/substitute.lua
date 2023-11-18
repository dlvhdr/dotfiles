return {
  "gbprod/substitute.nvim",
  opts = {
    highlight_substituted_text = {
      enabled = true,
      timer = 200,
    },
  },
  keys = {
    {
      "<leader>p",
      function(opts)
        require("substitute").operator(opts)
      end,
      desc = "Substitute",
    },
    {
      "<leader>pp",
      function(opts)
        require("substitute").line(opts)
      end,
      desc = "Substitute Line",
    },
    {
      "<leader>P",
      function(opts)
        require("substitute").eol(opts)
      end,
      desc = "Substitute to EOL",
    },
    {
      "<leader>p",
      function(opts)
        require("substitute").operator(opts)
      end,
      desc = "Substitute Visual",
      mode = "x",
    },
  },
}
