require("noice").setup({
  cmdline = {
    view = "cmdline_popup",
    opts = { buf_options = { filetype = "vim" } },
    format = {
      cmdline = { pattern = "^:", icon = "" },
      search_down = { kind = "search", pattern = "^/", icon = " ", ft = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = " ", ft = "regex" },
      filter = { pattern = "^:%s*!", icon = "$", opts = { buf_options = { filetype = "sh" } } },
      lua = { pattern = "^:%s*lua%s+", icon = "", opts = { buf_options = { filetype = "lua" } } },
    },
  },
  messages = {
    enabled = true,
    view = "mini",
    view_error = "mini",
    view_warn = "mini",
    view_history = "split",
    view_search = "virtualtext",
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
      view = "split",
      filter = {
        event = "msg_show",
        min_height = 4,
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
        width = "auto",
        height = "auto",
      },
    },
  },
})
