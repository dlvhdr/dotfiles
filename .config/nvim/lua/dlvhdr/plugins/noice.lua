local M = {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
M.config = function()
  local ok, noice = pcall(require, "noice")
  if not ok then
    return
  end

  noice.setup({
    presets = {
      lsp_doc_border = true,
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
    },
    format = {
      default = { "{title} ", "{message}" },
    },
    messages = {
      view_search = false,
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
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
      -- {
      --   filter = {
      --     event = "msg_show",
      --     kind = "lua_error",
      --     find = "more line",
      --   },
      --   opts = { skip = true },
      -- },
      -- {
      --   filter = {
      --     event = "msg_show",
      --     kind = "lua_error",
      --     find = "fewer line",
      --   },
      --   opts = { skip = true },
      -- },
      -- {
      --   filter = {
      --     event = "msg_show",
      --     kind = "lua_error",
      --     find = "line less",
      --   },
      --   opts = { skip = true },
      -- },
      -- {
      --   filter = {
      --     event = "msg_show",
      --     kind = "lua_error",
      --     find = "change;",
      --   },
      --   opts = { skip = true },
      -- },
      -- {
      --   filter = {
      --     event = "msg_show",
      --     kind = "",
      --     find = "more line",
      --   },
      --   opts = { skip = true },
      -- },
      -- {
      --   filter = {
      --     event = "msg_show",
      --     kind = "",
      --     find = "fewer line",
      --   },
      --   opts = { skip = true },
      -- },
      -- {
      --   filter = {
      --     event = "msg_show",
      --     kind = "",
      --     find = "line less",
      --   },
      --   opts = { skip = true },
      -- },
      -- {
      --   filter = {
      --     event = "msg_show",
      --     kind = "",
      --     find = "change;",
      --   },
      --   opts = { skip = true },
      -- },
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
end

return M
