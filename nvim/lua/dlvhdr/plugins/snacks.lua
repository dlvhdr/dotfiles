return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    gh = {},
    notifier = {
      enabled = true,
      timeout = 2000,
    },
    dashboard = {
      sections = {
        { section = "header", row = nil, padding = { 4, 15 } },
        {
          icon = " ",
          desc = "Last Session",
          padding = 1,
          key = "s",
          action = "<cmd>silent lua require('persistence').load()<CR>",
        },
        {
          icon = "󰛢 ",
          desc = "Grapple",
          padding = 1,
          key = "m",
          action = "<CMD>Grapple open_tags<CR>",
        },
        {
          icon = " ",
          desc = "New file",
          padding = 1,
          key = "e",
          action = "<CMD>ene <BAR> startinsert<CR>",
        },
        {
          icon = "󰅚 ",
          desc = "Quit",
          padding = 1,
          key = "q",
          action = "<CMD>qa<CR>",
        },
        { section = "startup", align = "center", padding = { 10, 4 } },
        {
          section = "terminal",
          cmd = "artprint --random -t dlvhdr --tc 5 --style 1",
          row = nil,
          align = "center",
          height = 30,
          padding = 10,
          width = 60,
          random = 200,
          gap = 2,
          pane = 2,
        },
      },
    },
    image = {
      enabled = true,
    },
    picker = {
      prompt = " ",
      sources = {},
      focus = "input",
      layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = function()
          return vim.o.columns >= 120 and "default" or "vertical"
        end,
      },
      ---@class snacks.picker.matcher.Config
      matcher = {
        fuzzy = true, -- use fuzzy matching
        smartcase = true, -- use smartcase
        ignorecase = true, -- use ignorecase
        sort_empty = false, -- sort results when the search string is empty
        filename_bonus = true, -- give bonus for matching file names (last part of the path)
        file_pos = true, -- support patterns like `file:line:col` and `file:line`
        -- the bonusses below, possibly require string concatenation and path normalization,
        -- so this can have a performance impact for large lists and increase memory usage
        cwd_bonus = false, -- give bonus for matching files in the cwd
        frecency = false, -- frecency bonus
        history_bonus = false, -- give more weight to chronological order
      },
      sort = {
        -- default sort is by score, text length and index
        fields = { "score:desc", "#text", "idx" },
      },
      ui_select = true, -- replace `vim.ui.select` with the snacks picker
      previewers = {
        -- git = {
        --   native = true,
        --   args = {
        --     "-c",
        --     "pager.diff=delta",
        --     "-c",
        --     "delta.side-by-side=false",
        --     "-c",
        --     "delta.line-numbers=false",
        --     "-c",
        --     "delta.navigate=false",
        --     "-c",
        --     "delta.file-style=omit",
        --     "-c",
        --     "delta.hunk-header-style=omit",
        --   },
        -- },
      },
      ---@class snacks.picker.formatters.Config
      formatters = {
        text = {
          ft = nil, ---@type string? filetype for highlighting
        },
        file = {
          filename_first = false, -- display filename before the file path
          truncate = 80, -- truncate the file path to (roughly) this length
          filename_only = false, -- only show the filename
          icon_width = 2, -- width of the icon (in characters)
          git_status_hl = true, -- use the git status highlight group for the filename
        },
        selected = {
          show_always = false, -- only show the selected column when there are multiple selections
          unselected = true, -- use the unselected icon for unselected items
        },
        severity = {
          icons = true, -- show severity icons
          level = false, -- show severity level
          ---@type "left"|"right"
          pos = "left", -- position of the diagnostics
        },
      },
      ---@class snacks.picker.jump.Config
      jump = {
        jumplist = true, -- save the current position in the jumplist
        reuse_win = false, -- reuse an existing window if the buffer is already open
        close = true, -- close the picker when jumping/editing to a location (defaults to true)
        match = false, -- jump to the first match position. (useful for `lines`)
      },
      toggles = {
        follow = "f",
        hidden = "h",
        ignored = "i",
        modified = "m",
        regex = { icon = "", value = true },
      },
      layouts = {
        default = {
          layout = {
            box = "horizontal",
            width = 0.9,
            height = 0.7,
            min_width = 80,
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
            { win = "preview", title = "{preview}", border = "rounded", width = 0.45 },
          },
        },
      },
      win = {
        -- input window
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config
            -- ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["/"] = "toggle_focus",
            ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
            ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
            ["<C-c>"] = { "close", mode = "i" },
            ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
            ["<CR>"] = { "confirm", mode = { "n", "i" } },
            ["<Down>"] = { "list_down", mode = { "i", "n" } },
            ["<Esc>"] = "close",
            ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
            ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
            ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
            ["<Up>"] = { "list_up", mode = { "i", "n" } },
            -- ["<a-d>"] = { "inspect", mode = { "n", "i" } },
            -- ["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
            -- ["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            -- ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            -- ["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
            ["<c-e>"] = { "toggle_maximize", mode = { "i", "n" } },
            ["<c-h>"] = { "toggle_preview", mode = { "i", "n" } },
            ["<c-a>"] = { "select_all", mode = { "n", "i" } },
            ["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
            ["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
            ["<c-j>"] = { "list_down", mode = { "i", "n" } },
            ["<c-k>"] = { "list_up", mode = { "i", "n" } },
            ["<c-n>"] = { "list_down", mode = { "i", "n" } },
            ["<c-p>"] = { "list_up", mode = { "i", "n" } },
            ["<c-q>"] = { "qflist", mode = { "i", "n" } },
            ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
            ["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
            ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
            ["<c-w>H"] = "layout_left",
            ["<c-w>J"] = "layout_bottom",
            ["<c-w>K"] = "layout_top",
            ["<c-w>L"] = "layout_right",
            ["?"] = "toggle_help_input",
            ["G"] = "list_bottom",
            ["gg"] = "list_top",
            ["j"] = "list_down",
            ["k"] = "list_up",
            ["q"] = "close",
          },
          b = {
            minipairs_disable = true,
          },
        },
        -- result list window
        list = {
          keys = {
            ["/"] = "toggle_focus",
            ["<2-LeftMouse>"] = "confirm",
            ["<CR>"] = "confirm",
            ["<Down>"] = "list_down",
            ["<Esc>"] = "close",
            ["<S-CR>"] = { { "pick_win", "jump" } },
            ["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
            ["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
            ["<Up>"] = "list_up",
            -- ["<a-d>"] = "inspect",
            -- ["<a-f>"] = "toggle_follow",
            -- ["<a-h>"] = "toggle_hidden",
            -- ["<a-i>"] = "toggle_ignored",
            -- ["<a-m>"] = "toggle_maximize",
            -- ["<a-p>"] = "toggle_preview",
            -- ["<a-w>"] = "cycle_win",
            ["<c-h>"] = "toggle_preview",
            ["<c-a>"] = "select_all",
            ["<c-b>"] = "preview_scroll_up",
            ["<c-d>"] = "list_scroll_down",
            ["<c-f>"] = "preview_scroll_down",
            ["<c-j>"] = "list_down",
            ["<c-k>"] = "list_up",
            ["<c-n>"] = "list_down",
            ["<c-p>"] = "list_up",
            ["<c-s>"] = "edit_split",
            ["<c-u>"] = "list_scroll_up",
            ["<c-v>"] = "edit_vsplit",
            ["<c-w>H"] = "layout_left",
            ["<c-w>J"] = "layout_bottom",
            ["<c-w>K"] = "layout_top",
            ["<c-w>L"] = "layout_right",
            ["?"] = "toggle_help_list",
            ["G"] = "list_bottom",
            ["gg"] = "list_top",
            ["i"] = "focus_input",
            ["j"] = "list_down",
            ["k"] = "list_up",
            ["q"] = "close",
            ["zb"] = "list_scroll_bottom",
            ["zt"] = "list_scroll_top",
            ["zz"] = "list_scroll_center",
          },
          wo = {
            conceallevel = 2,
            concealcursor = "nvc",
          },
        },
        -- preview window
        preview = {
          keys = {
            ["<Esc>"] = "close",
            ["q"] = "close",
            ["i"] = "focus_input",
            ["<ScrollWheelDown>"] = "list_scroll_wheel_down",
            ["<ScrollWheelUp>"] = "list_scroll_wheel_up",
            -- ["<a-w>"] = "cycle_win",
          },
        },
      },
      ---@class snacks.picker.icons
      icons = {
        files = {
          enabled = true, -- show file icons
        },
        keymaps = {
          nowait = "󰓅 ",
        },
        tree = {
          vertical = "│ ",
          middle = "├╴",
          last = "└╴",
        },
        undo = {
          saved = " ",
        },
        ui = {
          live = "󰐰 ",
          hidden = "h",
          ignored = "i",
          follow = "f",
          selected = "● ",
          unselected = "○ ",
          -- selected = " ",
        },
        git = {
          enabled = true, -- show git icons
          commit = "󰜘 ", -- used by git log
          staged = "●", -- staged changes. always overrides the type icons
          added = "",
          deleted = "",
          ignored = " ",
          modified = "○",
          renamed = "",
          unmerged = " ",
          untracked = "?",
        },
        diagnostics = {
          Error = " ",
          Warn = " ",
          Hint = " ",
          Info = " ",
        },
        lsp = {
          unavailable = "",
          enabled = " ",
          disabled = " ",
          attached = "󰖩 ",
        },
        kinds = {
          Array = " ",
          Boolean = "󰨙 ",
          Class = " ",
          Color = " ",
          Control = " ",
          Collapsed = " ",
          Constant = "󰏿 ",
          Constructor = " ",
          Copilot = " ",
          Enum = " ",
          EnumMember = " ",
          Event = " ",
          Field = " ",
          File = " ",
          Folder = " ",
          Function = "󰊕 ",
          Interface = " ",
          Key = " ",
          Keyword = " ",
          Method = "󰊕 ",
          Module = " ",
          Namespace = "󰦮 ",
          Null = " ",
          Number = "󰎠 ",
          Object = " ",
          Operator = " ",
          Package = " ",
          Property = " ",
          Reference = " ",
          Snippet = "󱄽 ",
          String = " ",
          Struct = "󰆼 ",
          Text = " ",
          TypeParameter = " ",
          Unit = " ",
          Unknown = " ",
          Value = " ",
          Variable = "󰀫 ",
        },
      },
    },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    bufdelete = { enabled = true },
    scratch = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
    {
      "<leader>fg",
      function()
        Snacks.picker.grep({
          actions = {
            -- toggles arg --fixed-strings
            toggle_regex = function(picker, item)
              local opts = picker.opts --[[@as snacks.picker.grep.Config]]
              opts.regex = not opts.regex
              picker:find()
            end,
            glob_filter = function(picker, item)
              local opts = picker.opts --[[@as snacks.picker.grep.Config]]
              local prev_glob = opts.glob
              local glob = vim.fn.input("Enter glob filter: ", prev_glob or "")
              if prev_glob == glob then
                return
              end
              opts.custom_glob = #glob > 0
              opts.glob = glob
              picker:find()
            end,
            no_tests = function(picker, item)
              local glob = "{!**/tests/**,!**/*.spec.cy.tsx}"
              local prev_glob = picker.opts.glob
              if prev_glob == glob then
                picker.opts.glob = ""
              else
                picker.opts.glob = glob
              end
              picker:find()
            end,
          },
          win = {
            input = {
              keys = {
                ["r"] = { "toggle_regex", mode = { "n" } },
                ["g"] = { "glob_filter", mode = { "n" } },
                ["t"] = { "no_tests", mode = { "n" } },
              },
            },
          },
          regex = false,
          args = {
            "-g",
            "!{node_modules,.git,.direnv,dist}/",
            "-g",
            "!tsconfig.tsbuildinfo",
            "-g",
            "!yarn.lock",
            "--trim",
            "--ignore-case",
          },
          exclude = { "%.lock$", "%-lock.json$", "tsconfig.tsbuildinfo" },
        })
      end,
      desc = "Grep",
    },
    {
      "<leader>*",
      function()
        Snacks.picker.grep({
          finder = "grep",
          format = "file",
          search = function(picker)
            return picker:word()
          end,
          live = false,
          supports_live = true,
        })
      end,
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.command_history({
          layout = {
            preset = "select",
          },
        })
      end,
      desc = "Command History",
    },
    {
      "<leader>n",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History",
    },
    -- find
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers({
          win = {
            input = {
              keys = {
                ["dd"] = "bufdelete",
                ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
              },
            },
            list = { keys = { ["dd"] = "bufdelete" } },
          },
          formatters = {
            file = {
              filename_first = true,
              truncate = 60,
            },
          },
        })
      end,
      desc = "Buffers",
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.git_status({
          icon = " ",
          preview = "git_status",
        })
      end,
      desc = "Git Status",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>fH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>fi",
      function()
        Snacks.picker.icons()
      end,
      desc = "Icons",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>fu",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>fR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
  },
}
