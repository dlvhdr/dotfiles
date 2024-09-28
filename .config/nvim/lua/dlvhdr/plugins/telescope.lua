local M = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    "kkharji/sqlite.lua",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    "aaronhallaert/advanced-git-search.nvim",
    "piersolenski/telescope-import.nvim",
    "nvim-telescope/telescope-node-modules.nvim",
    "fdschmidt93/telescope-egrepify.nvim",
    "benfowler/telescope-luasnip.nvim",
  },
  keys = {
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },
    { "<leader>fH", "<cmd>Telescope highlights<CR>", desc = "Highlights" },
    { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>fp", "<cmd>Telescope pickers<cr>", desc = "Pickers" },
    {
      "<leader>fs",
      function()
        local delta = {}
        if vim.fn.executable("delta") == 1 then
          local previewers = require("telescope.previewers")
          delta = previewers.new_termopen_previewer({
            get_command = function(entry)
              -- this is for status
              -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
              -- just do an if and return a different command
              if entry.status == "??" or "A " then
                return { "git", "-c", "pager.diff=delta", "-c", "delta.side-by-side=false", "diff", entry.value }
              end

              -- note we can't use pipes
              -- this command is for git_commits and git_bcommits
              return {
                "git",
                "-c",
                "pager.diff=delta",
                "-c",
                "delta.side-by-side=false",
                "diff",
                entry.value .. "^!",
              }
            end,
          })
        end
        require("telescope.builtin").git_status({
          previewer = delta,
          layout_config = {
            preview_width = 0.65,
          },
        })
      end,
      desc = "Git Status",
    },
    {
      "<leader>fb",
      function()
        require("dlvhdr.plugins.telescope").buffers()
      end,
      desc = "Open Buffers",
    },
    {
      "<leader>fg",
      function()
        require("telescope").extensions.egrepify.egrepify({})
      end,
      desc = "Live Grep",
    },
    {
      "<leader>*",
      function()
        require("telescope.builtin").grep_string()
      end,
      desc = "Grep Word Under Cursor",
    },
    {
      "<leader>fB",
      ":lua require('telescope.builtin').git_branches()<CR>",
      desc = "Git Branches",
    },
    { "<leader>fi", "<cmd>Telescope import<cr>", desc = "Imports" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    {
      "<leader>fG",
      ":lua require('dlvhdr.plugins.telescope').grep_current_dir()<CR>",
      desc = "Live Grep Current Dir",
    },
    {
      mode = { "n", "x", "o", "v" },
      "<leader>gda",
      function()
        require("telescope").extensions.advanced_git_search.show_custom_functions()
      end,
      desc = "Advanced Git Search",
    },
    {
      "<leader>fS",
      function()
        require("telescope").extensions.luasnip.luasnip({})
      end,
      desc = "Snippets",
    },
  },
}

M.config = function()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  local trouble_ok, trouble = pcall(require, "trouble.sources.telescope")
  if not trouble_ok then
    return
  end

  local actions = require("telescope.actions")
  local layout_actions = require("telescope.actions.layout")

  telescope.setup({
    defaults = {
      set_env = {
        LESS = "",
        DELTA_PAGER = "less",
        COLORTERM = "truecolor",
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--fixed-strings",
        "--trim",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      mappings = {
        i = {
          ["<c-t>"] = trouble.open,
          ["<c-h>"] = layout_actions.toggle_preview,
          ["<C-d>"] = actions.results_scrolling_down,
          ["<C-u>"] = actions.results_scrolling_up,
          ["<CR>"] = actions.select_default,
          ["<c-b>"] = actions.preview_scrolling_up,
          ["<c-f>"] = actions.preview_scrolling_down,
          ["<c-q>"] = actions.delete_buffer,
          ["<c-l>"] = layout_actions.cycle_layout_next,
          ["<c-e>"] = actions.to_fuzzy_refine,
        },
        n = {
          ["q"] = actions.close,
          ["<c-t>"] = trouble.open,
          ["<c-h>"] = layout_actions.toggle_preview,
          ["<C-d>"] = actions.results_scrolling_down,
          ["<C-u>"] = actions.results_scrolling_up,
          ["<c-b>"] = actions.preview_scrolling_up,
          ["<c-f>"] = actions.preview_scrolling_down,
          ["<c-l>"] = layout_actions.cycle_layout_next,
          ["<c-e>"] = actions.to_fuzzy_refine,
          ["<CR>"] = actions.select_default,
        },
      },
      cycle_layout_list = { "flex", "horizontal" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      path_display = { "truncate" },
      -- get_status_text = function()
      --   return ""
      -- end,
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
        scroll_speed = 10,
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
            preview_width = 0.7,
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
        "^.yarn/",
        "^generated/",
      },
    },
    pickers = {
      advanced_git_search = {
        layout_config = {
          horizontal = {
            preview_width = 0.8,
          },
        },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
      advanced_git_search = {
        git_flags = { "-c", "delta.side-by-side=false", "-c", "core.pager=delta", "-c", "delta.pager='less -RS'" },
        git_diff_flags = {},
        show_builtin_git_pickers = true,
        diff_plugin = "diffview",
        layout_config = {
          horizontal = {
            preview_width = 0.6,
          },
        },
      },
      import = {
        -- Add imports to the top of the file keeping the cursor in place
        insert_at_top = true,
      },
      egrepify = {
        lnum_hl = "LineNr",
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
        prefixes = {
          ["!"] = {
            flag = "invert-match",
          },
        },
      },
      smart_open = {
        preview = { hide_on_startup = true },
        layout_config = {
          width = 0.65,
        },
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
          },
        },
      },
    },
  })

  telescope.load_extension("ui-select")
  telescope.load_extension("advanced_git_search")
  telescope.load_extension("import")
  telescope.load_extension("node_modules")
  telescope.load_extension("fzy_native")
  telescope.load_extension("egrepify")
  telescope.load_extension("luasnip")
end

function M.project_files()
  local utils = require("telescope.utils")
  local _, ret, _ = utils.get_os_command_output({
    "git",
    "rev-parse",
    "--is-inside-work-tree",
  })

  local themes = require("telescope.themes")
  local gopts = themes.get_dropdown({
    use_git_root = true,
    preview = { hide_on_startup = true },
    layout_config = {
      width = 0.65,
    },
    show_untracked = true,
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
      },
    },
  })
  local fopts = {
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
      },
    },
  }

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
    fname_width = 40,
  })
end

function M.buffers()
  local layout_config = require("telescope.themes").get_dropdown({
    layout_config = {
      width = 0.65,
    },
  }).layout_config

  require("telescope.builtin").buffers({
    prompt_title = "Open Buffers",
    preview = { hide_on_startup = true },
    sort_mru = true,
    layout_strategy = "horizontal",
    sorting_strategy = "ascending",
    ignore_filename = false,
    bufnr_width = 0,
    layout_config = layout_config,
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
