vim.cmd("let $NVIM_TUI_ENABLE_TRUE_COLOR=1")
vim.cmd("syntax enable")
vim.g.tokyonight_italic_comments = true
vim.cmd("colorscheme tokyonight")

vim.g.tokyonight_style = "night"

vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#c0caf5" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1f2335" })
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "ActiveWindow", { ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "InactiveWindow", { ctermbg = "NONE" })

vim.cmd([[set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow]])
