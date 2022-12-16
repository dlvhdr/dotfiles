require("noice").setup({
  format = {
    default = { "{title} ", "{message}" },
  },
  messages = {
    view_search = false,
  },
  lsp = {
    progress = {
      enabled = false,
      format = {
        " ",
        { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
      },
      throttle = 250,
      view = "mini",
      format_done = {},
    },
  },
  routes = {
    {
      filter = { event = "msg_show", min_height = 3 },
      view = "split",
      opts = {},
    },
    {
      filter = {
        event = "msg_show",
        kind = "wmsg",
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
        width = "auto",
        height = "auto",
      },
    },
  },
})
