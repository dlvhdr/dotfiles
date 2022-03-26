local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Basic
keymap("x", "<leader>p", '"_dP', opts)
keymap("n", "Y", "y$", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("n", "<leader>j", ":m .+1<CR>==", opts)
keymap("n", "<leader>k", ":m .-2<CR>==", opts)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Alternate file
keymap("n", "<leader><leader>", "<C-^>", opts)
keymap("n", "<leader><tab>", "<C-^>", opts)

-- Telescope
keymap("n", "<leader>*", "<cmd>Telescope grep_string<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>gg", ":lua require('dlvhdr.telescope').grep_current_dir()<CR>", opts)
keymap("n", "<leader>fb", ":lua require('dlvhdr.telescope').buffers()<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "<leader>fs", "<cmd>Telescope projects<cr>", opts)
keymap("n", "<leader>gb", ":lua require('telescope.builtin').git_branches()<CR>", opts)
keymap("n", "<leader>fe", ":lua require('telescope.builtin').file_browser({cwd = '.'})<CR>", opts)
keymap("n", "<C-p>", ":lua require('dlvhdr.telescope').project_files()<CR>", opts)

-- Terminal
keymap("n", "<leader>t", "<cmd>ToggleTerm<CR>", opts)

-- nvim-tree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-- Trouble
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opts)
keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)

-- bbye
keymap("n", "<leader>qb", "<cmd>Bdelete<cr>", opts)
keymap("n", "<leader>qa", ":bufdo :Bdelete<cr>", opts)

-- persistence
keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], opts)
keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], opts)
keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], opts)

if vim.opt.diff:get() then
  keymap("n", "<leader>1", ":diffget LOCAL<CR>", opts)
  keymap("n", "<leader>2", ":diffget BASE<CR>", opts)
  keymap("n", "<leader>3", ":diffget REMOTE<CR>", opts)
end
