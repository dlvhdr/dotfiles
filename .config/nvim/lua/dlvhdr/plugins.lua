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
    "folke/which-key.nvim",
    enabled = false,
    config = function()
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
}
