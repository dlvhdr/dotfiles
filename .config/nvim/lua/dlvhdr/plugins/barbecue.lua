return {
  "utilyre/barbecue.nvim",
  dependencies = {
    "folke/tokyonight.nvim",
    "SmiteshP/nvim-navic",
    "neovim/nvim-lspconfig",
    "kyazdani42/nvim-web-devicons",
  },
  config = function()
    local theme = require("dlvhdr.plugins.theme")
    local colors = theme.colors()
    if not colors then
      return
    end

    require("barbecue").setup({
      attach_navic = false,
      show_navic = false,
      show_modified = true,
      symbols = {
        prefix = " ",
        separator = "",
        modified = "●",
        default_context = "…",
      },
    })
  end,
}
