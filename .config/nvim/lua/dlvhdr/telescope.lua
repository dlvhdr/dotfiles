local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local trouble_ok, trouble = pcall(require, "trouble.providers.telescope")
if not trouble_ok then
  return
end

local themes = require("telescope.themes")
local utils = require("telescope.utils")
local actions = require("telescope.actions")
local layout_actions = require("telescope.actions.layout")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["<c-h>"] = layout_actions.toggle_preview,
        ["<C-e>"] = actions.results_scrolling_down,
        ["<C-y>"] = actions.results_scrolling_up,
        ["<CR>"] = actions.select_default,
        ["<c-d>"] = actions.delete_buffer,
        ["<c-q>"] = actions.delete_buffer,
      },
      n = {
        ["q"] = actions.delete_buffer,
        ["x"] = actions.delete_buffer,
        ["<c-t>"] = trouble.open_with_trouble,
        ["<c-h>"] = layout_actions.toggle_preview,
        ["<C-e>"] = actions.results_scrolling_down,
        ["<C-y>"] = actions.results_scrolling_up,
        ["<CR>"] = actions.select_default,
      },
    },
    winblend = 0,
    path_display = { truncate = 5 },
    get_status_text = function()
      return ""
    end,
    preview = {
      filesize_limit = 3,
      timeout = 250,
    },
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    scroll_strategy = "limit",
    color_devicons = true,
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
      height = 0.85,
      prompt_position = "top",
      horizontal = {
        preview_width = function(_, cols, _)
          return math.floor(cols * 0.4)
        end,
      },

      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.55,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },
    file_ignore_patterns = {
      "^.vim/",
      "^.local/",
      "^.cache/",
      "^Downloads/",
      "^.git/",
      "^Dropbox/",
      "^Library/",
      "^undodir/",
      "^plugged/",
      "^sessions/",
      "^node_modules/",
    },
  },
  pickers = {
    live_grep = {
      layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
      },
      additional_args = function()
        return { "--hidden" }
      end,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
      }),
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
-- require("telescope").load_extension("projects")
-- require('session-lens').setup({path_display = {'shorten'}})
-- require("telescope").load_extension("session-lens")

-- Local Customizations
local M = {}

function M.project_files()
  local _, ret, _ = utils.get_os_command_output({
    "git",
    "rev-parse",
    "--is-inside-work-tree",
  })

  local gopts = themes.get_dropdown({
    use_git_root = true,
    preview = { hide_on_startup = true },
    layout_config = {
      width = 0.65,
    },
    show_untracked = true,
  })
  local fopts = {}

  gopts.prompt_title = "Git Files"

  fopts.prompt_title = "Find Files"
  fopts.hidden = true

  if ret == 0 then
    require("telescope.builtin").git_files(gopts)
  else
    require("telescope.builtin").find_files(fopts)
  end
end

function M.file_explorer()
  require("telescope.builtin").file_browser({
    prompt_title = "File Browser",
    cwd = "~",
    layout_strategy = "horizontal",
  })
end

function M.lsp_definitions()
  require("telescope.builtin").lsp_definitions({})
end

function M.lsp_references()
  require("telescope.builtin").lsp_references({
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  })
end

function M.buffers()
  require("telescope.builtin").buffers({
    prompt_title = "Open Buffers",
    sort_mru = true,
    layout_strategy = "horizontal",
    sorting_strategy = "ascending",
    ignore_filename = false,
    bufnr_width = 0,
  })
end

function M.grep_current_dir()
  local buffer_dir = require("telescope.utils").buffer_dir()
  local opts = {
    prompt_title = "Live Grep in " .. buffer_dir,
    cwd = buffer_dir,
  }
  require("telescope.builtin").live_grep(opts)
end

return M
