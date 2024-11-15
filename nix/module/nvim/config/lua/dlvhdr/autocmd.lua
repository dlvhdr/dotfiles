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
  pattern = { "*.md", "*.mdx" },
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
    "fugitiveblame",
    "CodeAction",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

local augroup = vim.api.nvim_create_augroup("CommandLineWindow", {})
vim.api.nvim_create_autocmd("CmdwinEnter", {
  group = augroup,
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close<cr>")
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
-- Copy text to clipboard using codeblock format ```{ft}{content}```
vim.api.nvim_create_user_command("CopyCodeBlock", function(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)
  local content = table.concat(lines, "\n")
  local result = string.format("```\n%s\n```", content)
  vim.fn.setreg("+", result)
  vim.notify("Text copied to clipboard")
end, { range = true })
