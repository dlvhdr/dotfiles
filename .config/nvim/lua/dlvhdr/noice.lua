require("noice").setup({
  cmdline = {
    view = "cmdline_popup",
    opts = { buf_options = { filetype = "vim" } },
    icons = {
      ["/"] = {
        icon = " ",
        hl_group = "DiagnosticInfo",
      },
      ["?"] = { icon = " ", hl_group = "DiagnosticInfo" },
      [":"] = { icon = " ", hl_group = "DiagnosticInfo", firstc = false },
    },
  },
  popupmenu = {
    enabled = true, -- disable if you use something like cmp-cmdline
    ---@type 'nui'|'cmp'
    backend = "nui", -- backend to use to show regular cmdline completions
    -- You can specify options for nui under `config.views.popupmenu`
  },
  routes = {
    {
      view = "split",
      filter = {
        event = "msg_show",
        min_height = 6,
      },
    },
    {
      filter = {
        event = "msg_show",
        kind = "msg_showcmd",
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "msg_show",
        find = "search hit",
      },
      opts = {
        skip = true,
      },
    },
    {
      view = "notify",
      filter = {
        event = "msg_show",
        find = "^%s*[/?]",
      },
      opts = {
        skip = true,
      },
    },
  },
  views = {
    cmdline_popup = {
      position = {
        row = "5",
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
      -- win_options = {
      --   winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" },
      -- },
      -- filter_options = {
      --   {
      --     filter = { event = "cmdline", find = "^%s*[/?]" },
      --     opts = {
      --       position = {
      --         row = "0%",
      --         col = "100%",
      --       },
      --       size = {
      --         width = 20,
      --       },
      --       border = {
      --         style = "rounded",
      --       },
      --       win_options = {
      --         winhighlight = {
      --           Normal = "NormalFloat",
      --           FloatBorder = "FloatBorder",
      --           IncSearch = "",
      --           Search = "",
      --         },
      --       },
      --     },
      --   },
      -- },
      -- border = {
      --   style = "rounded",
      --   text = {
      --     top = "",
      --   },
      -- },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
})
