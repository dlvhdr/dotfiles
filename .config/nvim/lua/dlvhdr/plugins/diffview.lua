local M = {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  keys = {
    { "<leader>gdm", "<cmd>DiffviewOpen master<cr>", desc = "Git Diff Master" },
  },
}

M.config = function()
  local status_ok, diffview = pcall(require, "diffview")
  if not status_ok then
    return
  end

  local actions = require("diffview.actions")

  diffview.setup({
    diff_binaries = false,
    enhanced_diff_hl = true,
    git_cmd = { "git" },
    use_icons = true,
    icons = {
      folder_closed = "",
      folder_open = "",
    },
    view = {
      diff_view = {
        layout = "diff2_horizontal",
      },
      merge_tool = {
        layout = "diff1_plain",
      },
    },
    signs = {
      fold_closed = "",
      fold_open = "",
    },
    file_panel = {
      win_config = {
        position = "right",
        width = 35,
      },
    },
    file_history_panel = {
      win_config = {
        position = "bottom",
        height = 10,
      },
    },
    commit_log_panel = {
      win_config = {},
    },
    default_args = {
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },
    hooks = {
      diff_buf_read = function(bufnr)
        -- Disable some performance heavy stuff in long files.
        if vim.api.nvim_buf_line_count(bufnr) >= 2500 then
          vim.cmd("IndentBlanklineDisable")
        end
      end,
    },
    keymaps = {
      view = {
        ["gf"] = actions.goto_file_edit,
        ["-"] = actions.toggle_stage_entry,
      },
      file_panel = {
        ["<cr>"] = actions.focus_entry,
        ["s"] = actions.toggle_stage_entry,
        ["gf"] = actions.goto_file_edit,
        ["?"] = "<Cmd>h diffview-maps-file-panel<CR>",
      },
      file_history_panel = {
        ["<cr>"] = actions.focus_entry,
        ["gf"] = actions.goto_file_edit,
        ["?"] = "<Cmd>h diffview-maps-file-history-panel<CR>",
      },
    },
  })
end

return M
