local util = require("dlvhdr.utils")
local keymap = vim.keymap.set

-- Basic
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
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
