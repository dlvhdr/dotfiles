local keymap = vim.keymap.set

-- Basic
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- save and quit
keymap("n", "<leader>w", ":silent write<CR>", { silent = true, desc = "Write File" })
keymap("n", "<leader>Q", ":quitall!<CR>", { silent = true, desc = "Quit Neovim" })
keymap("n", "<Leader>W", ":wall<CR>", { silent = true, desc = "Write All" })

keymap("n", "x", '"_x', { silent = true })
keymap("x", "<leader>p", '"_dP', { silent = true })
keymap("n", "Y", "y$", { silent = true })
keymap("n", "n", "nzzzv", { silent = true })
keymap("n", "N", "Nzzzv", { silent = true })
keymap("n", "J", "mzJ`z", { silent = true, desc = "Join Line Below" })
keymap("v", "<", "<gv", { silent = true, desc = "Indent Less" })
keymap("v", ">", ">gv", { silent = true, desc = "Indent More" })

-- disable Ex mode, I always enter in it by mistake
keymap("n", "Q", "<Nop>", { silent = true })

-- Alternate file
keymap("n", "<leader><leader>", "<C-^>", { silent = true, desc = "Last Buffer" })

keymap("n", "<leader>an", "<cmd>enew<cr>", { silent = true, desc = "New File" })
keymap("n", "<leader>ae", "<cmd>!eslint_d restart<CR>", { silent = true, desc = "Restart eslint_d" })

-- Telescope
keymap("n", "<leader>*", "<cmd>Telescope grep_string<cr>", { silent = true, desc = "Grep Word Under Cursor" })
keymap(
  "n",
  "<leader>fg",
  ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { silent = true, desc = "Live Grep" }
)
keymap(
  "n",
  "<leader>fG",
  ":lua require('dlvhdr.plugins.telescope').grep_current_dir()<CR>",
  { silent = true, desc = "Live Grep Current Dir" }
)
keymap(
  "n",
  "<leader>fb",
  ":lua require('dlvhdr.plugins.telescope').buffers()<CR>",
  { silent = true, desc = "Open Buffers" }
)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { silent = true, desc = "Help Tags" })
keymap("n", "<leader>fH", "<cmd>Telescope highlights<CR>", { silent = true, desc = "Highlights" })
keymap("n", "<leader>fr", "<cmd>Telescope resume<cr>", { silent = true, desc = "Resume" })
keymap("n", "<leader>fp", "<cmd>Telescope pickers<cr>", { silent = true, desc = "Pickers" })
keymap("n", "<leader>fs", ":lua require('telescope.builtin').git_status()<CR>", { silent = true, desc = "Git Status" })
keymap(
  "n",
  "<leader>fB",
  ":lua require('telescope.builtin').git_branches()<CR>",
  { silent = true, desc = "Git Branches" }
)
keymap(
  "n",
  "<C-p>",
  ":lua require('dlvhdr.plugins.telescope').project_files()<CR>",
  { silent = true, desc = "Project Files" }
)

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

-- zippy
keymap("n", "<leader>ag", "<cmd>lua require('zippy').insert_print()<CR>", { desc = "Add console.log" })

keymap("n", "<leader>aj", "<cmd>%!jq<cr>", { silent = true, desc = "Format JSON" })
keymap("n", "<leader>aJ", "<cmd>%!jq -c<cr>", { silent = true, desc = "Compact Format JSON" })

keymap("n", "<leader>af", "<cmd>lua vim.lsp.buf.format()<CR>", { silent = true, desc = "Format" })

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

vim.api.nvim_create_user_command("DiffCommitLine", function()
  require("telescope").extensions.advanced_git_search.diff_commit_line()
end, { range = true })
keymap("v", "<leader>gdl", ":DiffCommitLine<CR>", { noremap = true, desc = "Commits - Selected Lines" })
keymap("n", "<leader>gdf", function()
  require("telescope").extensions.advanced_git_search.search_log_content_file()
end, { noremap = true, desc = "Commits - File Contents" })
