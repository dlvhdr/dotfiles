local keymap = vim.keymap.set

-- Basic
keymap("n", "j", "gj", { silent = true })
keymap("n", "k", "gk", { silent = true })

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
keymap("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move Line Down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move Line Up" })
keymap("v", "<", "<gv", { silent = true, desc = "Indent Less" })
keymap("v", ">", ">gv", { silent = true, desc = "Indent More" })

-- disable Ex mode, I always enter in it by mistake
keymap("n", "Q", "<Nop>", { silent = true })

-- Alternate file
keymap("n", "<leader><leader>", "<C-^>", { silent = true, desc = "Last Buffer" })

-- -- LSP
-- keymap("n", "<leader>lr", function()
--   local configs = require("lspconfig.configs")
--   for _, client in
--     ipairs(vim.lsp.get_active_clients({
--       bufnr = vim.api.nvim_get_current_buf(),
--     }))
--   do
--     if client.name ~= "null-ls" then
--       os.execute("eslint_d restart")
--       os.execute("prettierd restart")
--       client.stop()
--       vim.defer_fn(function()
--         configs[client.name].launch()
--       end, 500)
--     end
--   end
-- end, { silent = true, desc = "" })

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

keymap("n", "<Leader>ah", ":set hlsearch!<CR>", { silent = true, desc = "Toggle highlighted search" })
-- keymap("n", "<leader>m", 'ysiW"', { silent = true, desc = "Surround With Quotes" })

-- zippy
keymap("n", "<leader>ag", "<cmd>lua require('zippy').insert_print()<CR>", { desc = "Add console.log" })

keymap("n", "<leader>aj", "<cmd>%!jq<cr>", { silent = true, desc = "Format JSON" })
keymap("n", "<leader>aJ", "<cmd>%!jq -c<cr>", { silent = true, desc = "Compact Format JSON" })

keymap("n", "<leader>af", "<cmd>lua vim.lsp.buf.format()<CR>", { silent = true, desc = "Format" })

keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true, desc = "Next Diagnostic" })
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true, desc = "Previous Diagnostic" })

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

-- gitlinker
-- <leader>gy copies url to the current line in this file on github
