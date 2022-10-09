require("noice").setup({
  cmdline = {
    view = "cmdline_popup",
    icons = {
      ["/"] = {
        icon = " ",
        hl_group = "DiagnosticInfo",
      },
      ["?"] = { icon = " ", hl_group = "DiagnosticInfo" },
      [":"] = { icon = " ", hl_group = "DiagnosticInfo", firstc = false },
    },
  },
  notify = {
    backend = "notifier",
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
        row = "90%",
        col = "50%",
      },
      win_options = {
        winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" },
      },
      filter_options = {
        {
          filter = { event = "cmdline", find = "^%s*[/?]" },
          opts = {
            position = {
              row = "0%",
              col = "100%",
            },
            size = {
              width = 20,
            },
            border = {
              style = "rounded",
            },
            win_options = {
              winhighlight = {
                Normal = "NormalFloat",
                FloatBorder = "FloatBorder",
                IncSearch = "",
                Search = "",
              },
            },
          },
        },
      },
      border = {
        style = "rounded",
        text = {
          top = "",
        },
      },
    },
  },
})
