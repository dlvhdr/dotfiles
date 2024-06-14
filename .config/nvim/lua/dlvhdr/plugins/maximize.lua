return {
  "declancm/maximize.nvim",
  keys = {
    {
      "<leader>bz",
      function()
        require("maximize").toggle()
      end,
      desc = "Maximize current buffer",
    },
  },
  config = function()
    require("maximize").setup()
  end,
}
