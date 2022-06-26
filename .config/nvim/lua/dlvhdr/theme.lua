local colors = require("tokyonight.colors").setup({})
local util = require("tokyonight.util")

vim.o.background = "dark"
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_sidebars = {
  "terminal",
  "packer",
  "help",
  "NvimTree",
}
vim.g.tokyonight_cterm_colors = false
vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_transparent = false
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_colors = { bg_popup = util.darken(colors.bg_popup, 1.8) }

vim.cmd("colorscheme tokyonight")
