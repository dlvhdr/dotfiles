return {
  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  "christoomey/vim-tmux-navigator",
  {
    "axelvc/template-string.nvim",
    dependencies = {
      "nvim-treesitter",
    },
    event = "InsertEnter",
    config = function()
      require("template-string").setup({})
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup()
    end,
    event = "VimEnter",
  },
}
