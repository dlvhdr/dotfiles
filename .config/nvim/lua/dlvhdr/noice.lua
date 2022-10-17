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
  routes = {
    {
      filter = {
        event = "msg_show",
        kind = "wmsg",
      },
      opts = { skip = true },
    },
    {
      view = "virtualtext",
      filter = {
        event = "msg_show",
        kind = "search_count",
      },
    },
    {
      view = "mini",
      filter = {
        event = "msg_show",
      },
    },
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
  },
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
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
