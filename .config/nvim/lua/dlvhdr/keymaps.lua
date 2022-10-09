local keymap = vim.keymap.set
local opts = { silent = true }

-- Basic
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- save and quit
keymap("n", "<leader>q", ":silent Bdelete<CR>", opts)
keymap("n", "<leader>w", ":silent write<CR>", opts)
keymap("n", "<leader>Q", ":quitall!<CR>", opts)
keymap("n", "<Leader>W", ":wall<CR>", opts)

-- open new buffer
keymap("n", "<leader>n", ":enew<CR>", opts)

keymap("n", "x", '"_x', opts)
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

-- disable Ex mode, I always enter in it by mistake
keymap("n", "Q", "<Nop>", opts)

-- Alternate file
keymap("n", "<leader><leader>", "<C-^>", opts)
keymap("n", "<leader><tab>", "<C-^>", opts)

-- LSP
keymap("n", "<leader>lr", "<cmd>LspRestart<CR>", opts)
keymap("n", "<leader>le", "<cmd>!eslint_d restart<CR>", opts)

-- Telescope
keymap("n", "<leader>*", "<cmd>Telescope grep_string<cr>", opts)
-- keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
keymap("n", "<leader>gg", ":lua require('dlvhdr.telescope').grep_current_dir()<CR>", opts)
keymap("n", "<leader>fb", ":lua require('dlvhdr.telescope').buffers()<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", "<cmd>Telescope resume<cr>", opts)
keymap("n", "<leader>fp", "<cmd>Telescope pickers<cr>", opts)
keymap("n", "<leader>fs", ":lua require('telescope.builtin').git_status()<CR>", opts)
keymap("n", "<leader>gb", ":lua require('telescope.builtin').git_branches()<CR>", opts)
keymap("n", "<leader>fe", ":lua require('telescope.builtin').file_browser({cwd = '.'})<CR>", opts)
keymap("n", "<C-p>", ":lua require('dlvhdr.telescope').project_files()<CR>", opts)

-- nvim-tree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-- Trouble
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opts)
keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)

if vim.opt.diff:get() then
  keymap("n", "<leader>1", ":diffget LOCAL<CR>", opts)
  keymap("n", "<leader>2", ":diffget BASE<CR>", opts)
  keymap("n", "<leader>3", ":diffget REMOTE<CR>", opts)
end

keymap("n", "<Leader>h", ":set hlsearch!<CR>", opts)
keymap("n", "<Leader>a", 'ysiW"', opts)

keymap("n", "<F10>", function()
  if vim.o.conceallevel > 0 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
  end
end, opts)

keymap("n", "<F11>", function()
  if vim.o.concealcursor == "n" then
    vim.o.concealcursor = ""
  else
    vim.o.concealcursor = "n"
  end
end, opts)

-- gitlinker
-- <leader>gy copies url to the current line in this file on github
