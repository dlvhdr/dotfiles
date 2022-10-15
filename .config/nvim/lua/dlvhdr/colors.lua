local status_ok, colors = pcall(require, "tokyonight.colors")
if not status_ok then
  return
end

colors = colors.setup({})

local util_ok, util = pcall(require, "tokyonight.util")
if not util_ok then
  return
end

vim.cmd("hi! NvimTreeSpecialFile guifg=" .. colors.warning)
vim.cmd("hi! FidgetTitle guifg=#3d59a1 guibg=none")
vim.cmd("hi! FidgetTask guifg=#3d59a1 guibg=none")
vim.cmd("hi! WinSeparator guibg=NONE guifg=" .. util.darken(colors.border_highlight, 0.3))

local darker_bg = util.darken(colors.bg_popup, 2.5)
vim.cmd("hi! CmpDocumentation guibg=" .. darker_bg)
vim.cmd("hi! CmpDocumentationBorder guibg=" .. darker_bg)
vim.cmd("hi! TelescopeMatching guifg=" .. colors.warning .. " gui=bold")
vim.cmd("hi! TreesitterContext guibg=" .. colors.bg_highlight)
vim.cmd("hi! NvimTreeFolderIcon guifg=" .. colors.blue)
vim.cmd("hi! BarbecueMod guibg=NONE guifg=" .. colors.yellow)

vim.cmd("hi! GHThreadSep guibg=" .. colors.bg_float)
vim.cmd("hi! markdownH1 guibg=" .. colors.bg_float)

vim.cmd("hi! CmpBorder guibg=none guifg=" .. colors.fg_gutter)
vim.cmd("hi! CmpDocBorder guibg=none guifg=" .. colors.fg_gutter)

vim.cmd("hi! TelescopeBorder guibg=none guifg=" .. colors.fg_gutter)
vim.cmd("hi! TelescopePromptTitle guibg=none guifg=" .. colors.blue)
vim.cmd("hi! TelescopeResultsTitle guibg=none guifg=" .. colors.teal)
vim.cmd("hi! TelescopePreviewTitle guibg=none guifg=" .. colors.fg)
vim.cmd("hi! TelescopePromptPrefix guibg=none guifg=" .. colors.blue)
vim.cmd("hi! TelescopeResultsDiffAdd guibg=none guifg=" .. colors.green)
vim.cmd("hi! TelescopeResultsDiffChange guibg=none guifg=" .. colors.yellow)
vim.cmd("hi! TelescopeResultsDiffDelete guibg=none guifg=" .. colors.red)
vim.cmd("hi! TelescopeMatching guifg=" .. colors.green .. " gui=bold")

vim.cmd("hi! NvimTreeSpecialFile guifg=" .. colors.yellow .. " gui=bold")

vim.cmd("hi! DevIconFish guifg=" .. colors.green)

vim.cmd("hi! Folded gui=italic guibg=" .. colors.bg_popup)
vim.cmd("hi! FoldColumn guifg=" .. colors.blue)
