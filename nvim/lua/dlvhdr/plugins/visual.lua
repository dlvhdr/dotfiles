return {
  "mcauley-penney/visual-whitespace.nvim",
  config = function()
    local colors = require("tokyonight.colors").setup()
    local util = require("tokyonight.util")
    local ws_bg = colors.bg_visual
    local ws_fg = util.darken(colors.comment, 0.7)

    require("visual-whitespace").setup({
      highlight = { bg = ws_bg, fg = ws_fg },
      use_listchars = true,
      nl_char = "",
    })
  end,
}
