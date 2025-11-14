local M = {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

M.config = function()
  local status_ok, gitsigns = pcall(require, "gitsigns")
  if not status_ok then
    return
  end

  gitsigns.setup({
    signs = {
      add = { text = "▌" },
      change = { text = "▌" },
      delete = { text = "▌" },
      topdelete = { text = "▌" },
      changedelete = { text = "▌" },
      untracked = { text = "▌" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]h", function()
        if vim.wo.diff then
          return "]h"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Next Git Hunk" })

      map("n", "[h", function()
        if vim.wo.diff then
          return "[h"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Previous Git Hunk" })

      map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
      map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
      map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
      map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
      map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
      map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, { desc = "Blame Line" })
      map("n", "<leader>hg", gs.toggle_current_line_blame, { desc = "  Current Line Blame" })
      map("n", "<leader>hd", gs.diffthis, { desc = "Diff" })
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end, { desc = "Diff ~" })
      map("n", "<leader>ht", gs.toggle_deleted, { desc = "Toggle Deleted" })

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 500,
      ignore_whitespace = false,
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
  })
end

return M
