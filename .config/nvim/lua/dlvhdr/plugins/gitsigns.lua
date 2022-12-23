local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufRead",
}

M.config = function()
  local status_ok, gitsigns = pcall(require, "gitsigns")
  if not status_ok then
    return
  end

  gitsigns.setup({
    signs = {
      add = { hl = "GitSignsAdd", text = "▌", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = { hl = "GitSignsChange", text = "▌", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete = { hl = "GitSignsDelete", text = "▌", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = { hl = "GitSignsDelete", text = "▌", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      changedelete = { hl = "GitSignsChange", text = "▌", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    on_attach = function(bufnr)
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
    end,
    keymaps = {
      noremap = true,

      ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" },
      ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" },

      -- Text objects
      ["o ih"] = ":<C-U>Gitsigns select_hunk<CR>",
      ["x ih"] = ":<C-U>Gitsigns select_hunk<CR>",
    },
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
      relative_time = false,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    yadm = {
      enable = false,
    },
  })
end

return M
