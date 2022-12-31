-- Highlighted Yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

vim.cmd("language en_US.utf-8")

vim.cmd("command! W wqa")
vim.cmd("command! Q wqa!")

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

vim.api.nvim_create_autocmd({ "BufRead,BufNewFile" }, {
  pattern = "*.json",
  callback = function()
    vim.o.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd({ "BufRead,BufNewFile" }, {
  pattern = "*.md",
  callback = function()
    vim.o.conceallevel = 2
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = { "DiffviewViewEnter", "DiffviewViewLeave" },
  callback = function()
    local ok, barbecue = pcall(require, "barbecue.ui")
    if not ok then
      return
    end
    barbecue.toggle()
  end,
})

vim.api.nvim_create_autocmd({ "TabClosed" }, {
  callback = function()
    vim.opt.showtabline = 1
  end,
})
