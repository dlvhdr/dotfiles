vim.cmd("let $NVIM_TUI_ENABLE_TRUE_COLOR=1")
vim.cmd("syntax enable")
vim.cmd("colorscheme tokyonight")
vim.cmd([[
  hi CursorLineNr guifg=#c0caf5 
  hi CursorLine guibg=#1f2335
]])
vim.g.tokyonight_style = "night"
vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
vim.cmd([[hi ActiveWindow ctermbg=NONE | hi InactiveWindow ctermbg=NONE]])
vim.cmd([[set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow]])
