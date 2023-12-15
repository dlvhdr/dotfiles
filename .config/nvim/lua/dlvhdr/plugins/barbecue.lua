return {
  "utilyre/barbecue.nvim",
  event = "BufReadPre",
  dependencies = {
    "folke/tokyonight.nvim",
    "SmiteshP/nvim-navic",
    "neovim/nvim-lspconfig",
    "kyazdani42/nvim-web-devicons",
  },
  config = function()
    local colors = require("tokyonight.colors").setup()
    require("barbecue").setup({
      attach_navic = false,
      show_navic = false,
      show_modified = true,
      theme = {
        separator = { fg = colors.bg },
      },
      symbols = {
        prefix = " ",
        separator = "",
        modified = "●",
        default_context = "…",
      },
      lead_custom_section = function()
        local root = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        return { { root, "StatusLineWinnr" }, { "  ", "VertSplit" } }
      end,
    })
  end,
}
