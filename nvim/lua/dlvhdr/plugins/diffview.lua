local M = {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  keys = {
    { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Diff Open" },
    { "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    { "<leader>gdm", "<cmd>DiffviewOpen master<cr>", desc = "Diff Master" },
    { "<leader>gdM", "<cmd>DiffviewOpen main<cr>", desc = "Diff Main" },
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
    show_help_hints = true,
    icons = {
      folder_closed = "",
      folder_open = "",
    },
    view = {
      default = {
        winbar_info = true,
      },
      diff_view = {
        winbar_info = true,
        layout = "diff2_horizontal",
      },
      merge_tool = {
        winbar_info = true,
        layout = "diff3_mixed",
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
      -- diff_buf_win_enter = function(bufnr, winid, ctx)
      --   if ctx.layout_name:match("^diff2") then
      --     if ctx.symbol == "a" then
      --       vim.opt_local.winhl = table.concat({
      --         "DiffAdd:DiffviewDiffAddAsDelete",
      --         "DiffDelete:DiffviewDiffDelete",
      --       }, ",")
      --     elseif ctx.symbol == "b" then
      --       vim.opt_local.winhl = table.concat({
      --         "DiffDelete:DiffviewDiffDelete",
      --       }, ",")
      --     end
      --   end
      -- end,
      diff_buf_win_enter = function(_, _, ctx)
        -- Highlight 'DiffChange' as 'DiffDelete' on the left, and 'DiffAdd' on the right.
        if ctx.layout_name:match("^diff2") then
          if ctx.symbol == "a" then
            vim.opt_local.winhl = table.concat({
              "DiffAdd:DiffviewDiffAdd",
              "DiffDelete:DiffviewDiffDelete",
              "DiffChange:DiffviewDiffDeleteDim",
              "DiffText:DiffviewDiffDelete",
            }, ",")
          elseif ctx.symbol == "b" then
            vim.opt_local.winhl = table.concat({
              "DiffAdd:DiffviewDiffAdd",
              "DiffDelete:DiffviewDiffDelete",
              -- "DiffChange:DiffAdd",
            }, ",")
          end
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
