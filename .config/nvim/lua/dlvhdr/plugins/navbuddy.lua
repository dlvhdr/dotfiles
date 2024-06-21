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
      opts = {
        lsp = { auto_attach = true },
        window = {
          border = "rounded",
          position = { row = 1, col = 0 },
          size = { width = "90%", height = "30%" },
          sections = {
            left = {
              size = "33%",
              border = nil,
            },
            mid = {
              size = "33%",
              border = nil,
            },
            right = {
              border = nil,
              preview = "leaf",
            },
          },
        },
        source_buffer = {
          reorient = "mid",
        },
        custom_hl_group = "Visual",
      },
    },
  },
}
