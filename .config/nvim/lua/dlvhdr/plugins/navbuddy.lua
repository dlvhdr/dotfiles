return {
  "neovim/nvim-lspconfig",
  keys = {
    {
      "<leader>ff",
      function()
        require("nvim-navbuddy").open()
      end,
      desc = "Navbuddy",
    },
  },
  dependencies = {
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
      opts = { lsp = { auto_attach = true } },
    },
  },
}
