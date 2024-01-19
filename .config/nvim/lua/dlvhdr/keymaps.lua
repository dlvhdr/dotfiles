local util = require("dlvhdr.utils")
local keymap = vim.keymap.set

-- Store relative line number jumps in the jumplist.
keymap("n", "j", [[(v:count > 1 ? 'm`' . v:count : '') . 'gj']], { expr = true, silent = true })
keymap("n", "k", [[(v:count > 1 ? 'm`' . v:count : '') . 'gk']], { expr = true, silent = true })

keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
keymap({ "n" }, "<CR>", "viw", { desc = "Select word under cursor" })

-- save and quit
keymap("n", "<leader><Tab>d", ":tabclose<CR>", { silent = true, desc = "Close Tab" })
keymap("n", "<leader><Tab>n", ":tabnext<CR>", { silent = true, desc = "Next Tab" })
keymap("n", "<leader><Tab>p", ":tabprevious<CR>", { silent = true, desc = "Previous Tab" })

keymap("n", "x", '"_x', { silent = true })
keymap("n", "Y", "y$", { silent = true })
keymap("n", "n", "nzzzv", { silent = true })
keymap("n", "N", "Nzzzv", { silent = true })
keymap("n", "gj", "mzJ`z", { silent = true, desc = "Join Line Below" })
keymap("v", "<", "<gv", { silent = true, desc = "Indent Less" })
keymap("v", ">", ">gv", { silent = true, desc = "Indent More" })
keymap("n", "<C-e>", "<Nop>", { silent = true, desc = "Scroll screen down" })
keymap("n", "<C-y>", "3<C-y>", { silent = true, desc = "Scroll screen up" })

-- disable Ex mode, I always enter in it by mistake
keymap("n", "Q", "<Nop>", { silent = true })

-- buffers
keymap("n", "<leader><leader>", "<C-^>", { silent = true, desc = "Last Buffer" })
keymap("n", "<leader>bn", "<cmd>enew<cr>", { silent = true, desc = "New File" })
keymap("n", "<leader>bo", function()
  local current_buffer = vim.api.nvim_get_current_buf()

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr ~= current_buffer then
      vim.api.nvim_buf_delete(bufnr, {})
    end
  end
end, { desc = "Close Other Buffers" })
keymap("n", "<leader>bw", "<cmd>w<cr>", { silent = true, desc = "Write File" })
keymap("n", "<leader>bW", "<cmd>w<cr>", { silent = true, desc = "Write All Files" })
keymap("n", "<leader>bQ", "<cmd>qa!<cr>", { silent = true, desc = "Quit nvim" })
keymap("n", "<leader>by", function()
  vim.api.nvim_call_function("setreg", { "+", vim.fn.fnamemodify(vim.fn.expand("%:t"), ":.") })
end, { silent = true, desc = "Copy File Name" })
keymap("n", "<leader>bp", function()
  vim.api.nvim_call_function("setreg", { "+", vim.fn.fnamemodify(vim.fn.expand("%"), ":.") })
end, { silent = true, desc = "Copy File Name" })

keymap("n", "<leader>fm", "<cmd>messages<cr>", { silent = true, desc = "Messages" })
keymap("n", "<leader>fn", "<cmd>Noice telescope<cr>", { silent = true, desc = "Noice" })

keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { silent = true, desc = "Toggle File Tree" })

-- Trouble
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, desc = "Toggle Trouble" })
keymap(
  "n",
  "<leader>xw",
  "<cmd>Trouble lsp_workspace_diagnostics<cr>",
  { silent = true, desc = "Workspace Diagnostics" }
)
keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, desc = "Document Diagnostics" })
keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, desc = "Loclist" })
keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, desc = "Quickfix" })
keymap("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", { silent = true, desc = "LSP References" })

if vim.opt.diff:get() then
  keymap("n", "<leader>1", ":diffget LOCAL<CR>", { silent = true, desc = "Take Local" })
  keymap("n", "<leader>2", ":diffget BASE<CR>", { silent = true, desc = "Take Base" })
  keymap("n", "<leader>3", ":diffget REMOTE<CR>", { silent = true, desc = "Take Remote" })
end

keymap("n", "<leader>cj", "<cmd>%!jq<cr>", { silent = true, desc = "Format JSON" })
keymap("n", "<leader>cJ", "<cmd>%!jq -c<cr>", { silent = true, desc = "Compact Format JSON" })

keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format()<CR>", { silent = true, desc = "Format" })

keymap("n", "<F10>", function()
  if vim.o.conceallevel > 0 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
  end
end, { silent = true, desc = "" })

keymap("n", "<F11>", function()
  if vim.o.concealcursor == "n" then
    vim.o.concealcursor = ""
  else
    vim.o.concealcursor = "n"
  end
end, { silent = true, desc = "" })

vim.g.tmux_resizer_resize_count = 2
vim.g.tmux_resizer_vertical_resize_count = 2
vim.g.tmux_resizer_no_mappings = 1
keymap("n", "<C-M-k>", "<cmd>:TmuxResizeUp<CR>", { silent = true })
keymap("n", "<C-M-j>", "<cmd>:TmuxResizeDown<CR>", { silent = true })
keymap("n", "<C-M-h>", "<cmd>:TmuxResizeLeft<CR>", { silent = true })
keymap("n", "<C-M-l>", "<cmd>:TmuxResizeRight<CR>", { silent = true })

keymap("n", "<leader>cL", function()
  util.toggle("relativenumber")
end, { silent = true, desc = "Toggle Relative Line Numbers" })

-- quick find and replace
keymap("n", "<leader>cr", [[:%s/\<<C-r>=expand("<cword>")<CR>\>/]], {
  silent = false,
  desc = "Replace Word Under Cursor (File)",
})
keymap("n", "<leader>cR", [[gv:s/\<<C-r>=expand("<cword>")<CR>\>/]], {
  silent = false,
  desc = "Replace Word Under Cursor (Last Selection)",
})
keymap("v", "<leader>cr", [["zy:%s/<C-r><C-o>"/]], {
  silent = false,
  desc = "Replace Word Under Cursor (Visual)",
})

-- TLDR: Conditionally modify character at end of line
-- Description:
-- This function takes a delimiter character and:
--   * removes that character from the end of the line if the character at the end
--     of the line is that character
--   * removes the character at the end of the line if that character is a
--     delimiter that is not the input character and appends that character to
--     the end of the line
--   * adds that character to the end of the line if the line does not end with
--     a delimiter
-- Delimiters:
-- - ","
-- - ";"
---@param character string
---@return function
local function modify_line_end_delimiter(character)
  local delimiters = { ",", ";" }
  return function()
    local line = vim.api.nvim_get_current_line()
    local last_char = line:sub(-1)
    if last_char == character then
      vim.api.nvim_set_current_line(line:sub(1, #line - 1))
    elseif vim.tbl_contains(delimiters, last_char) then
      vim.api.nvim_set_current_line(line:sub(1, #line - 1) .. character)
    else
      vim.api.nvim_set_current_line(line .. character)
    end
  end
end

keymap("n", "<leader>c,", modify_line_end_delimiter(","), { desc = "add ',' to end of line" })
keymap("n", "<leader>c;", modify_line_end_delimiter(";"), { desc = "add ';' to end of line" })

-----------------------------------------------------------------------------//
-- Multiple Cursor Replacement
-- http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
-----------------------------------------------------------------------------//
keymap("n", "<leader>cn", "*``cgn", { desc = "Replace Next Occurrence" })
keymap("n", "cN", "*``cgN", { desc = "Replace Next Occurrence (Backwards)" })

-----------------------------------------------------------------------------//
-- GX - replicate netrw functionality
-----------------------------------------------------------------------------//
local function open(path)
  vim.fn.jobstart({ vim.g.open_command, path }, { detach = true })
  vim.notify(string.format("Opening %s", path))
end
keymap("n", "gx", function()
  local file = vim.fn.expand("<cfile>")
  if not file or vim.fn.isdirectory(file) > 0 then
    return vim.cmd.edit(file)
  end

  if file:match("http[s]?://") then
    return open(file)
  end

  -- consider anything that looks like string/string a github link
  local link = file:match("[%a%d%-%.%_]*%/[%a%d%-%.%_]*")
  if link then
    return open(string.format("https://www.github.com/%s", link))
  end
end)
-----------------------------------------------------------------------------//

keymap("n", "<leader>ty", function()
  vim.api.nvim_call_function("setreg", {
    "+",
    "yarn test " .. vim.fn.fnamemodify(vim.fn.expand("%:t"), ":."),
  })
end)
