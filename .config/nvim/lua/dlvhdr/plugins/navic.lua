return {
  "SmiteshP/nvim-navic",
  dependencies = { "folke/tokyonight.nvim", "kyazdani42/nvim-web-devicons" },
  config = function()
    vim.g.navic_silence = true
    require("nvim-navic").setup({ separator = " › ", highlight = true, depth_limit = 3 })

    local theme = require("dlvhdr.plugins.theme")
    local colors = theme.colors()
    if not colors then
      return
    end
  end,
}
