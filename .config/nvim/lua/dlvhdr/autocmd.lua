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
augroup zsh-filetype
  autocmd BufNewFile,BufRead *.zsh set syntax=bash
  autocmd BufNewFile,BufRead *.zsh set filetype=sh
augroup END
]])

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.json",
  callback = function()
    vim.o.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md",
  callback = function()
    vim.o.conceallevel = 2
  end,
})

-- vim.api.nvim_create_autocmd("User", {
--   pattern = { "DiffviewViewEnter", "DiffviewViewLeave" },
--   callback = function()
--     local ok, barbecue = pcall(require, "barbecue.ui")
--     if not ok then
--       return
--     end
--     barbecue.toggle()
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "TabEnter" }, {
--   callback = function()
--     vim.o.showtabline = 1
--   end,
-- })

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

local FormatOptions = vim.api.nvim_create_augroup("FormatOptions", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = FormatOptions,
  pattern = "*",
  desc = "Set buffer local formatoptions.",
  callback = function()
    vim.opt_local.formatoptions:remove({
      "r", -- Automatically insert the current comment leader after hitting <Enter> in Insert mode.
      "o", -- Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
    })
  end,
})
