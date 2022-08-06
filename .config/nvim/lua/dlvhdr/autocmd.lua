-- Highlighted Yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  command = "silent! lua require('nvim-lightbulb').update_lightbulb() end",
})

vim.fn.sign_define("LightBulbSign", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })

vim.cmd("language en_US.utf-8")

vim.cmd("autocmd User LspProgressUpdate redrawstatus")
vim.cmd("autocmd User LspRequest redrawstatus")

vim.cmd("command! W wqa")
vim.cmd("command! Q wqa!")

vim.cmd([[
augroup ConfigureKitty
    au!
    au VimLeave * :silent !kitty @ set-spacing padding=20 margin=10
    au VimEnter * :silent !kitty @ set-spacing padding=0 margin=0
augroup END
]])

vim.cmd([[
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
]])

vim.cmd([[
augroup zsh-filetype
  autocmd BufNewFile,BufRead *.zsh set syntax=bash
  autocmd BufNewFile,BufRead *.zsh set filetype=sh
augroup END
]])
