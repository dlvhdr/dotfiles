local M = {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}

M.config = function()
  require("noice").setup({
    presets = {
      command_palette = true,
      lsp_doc_border = true,
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
    },
    format = {
      default = { "{title} ", "{message}" },
    },
    messages = {
      view_search = false,
    },
    cmdline = {
      format = {
        cmdline = { pattern = "^:", icon = "", lang = "vim" },
      },
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
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        opts = { skip = true },
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
      mini = {
        zindex = 100,
        win_options = { winblend = 0 },
      },
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

M.keys = {
  {
    "<C-d>",
    function()
      if not require("noice.lsp").scroll(4) then
        return "10jzz"
      end
    end,
    mode = { "i", "n" },
    silent = true,
    expr = true,
    desc = "Scroll forward",
  },
  {
    "<C-u>",
    function()
      if not require("noice.lsp").scroll(-4) then
        return "10kzz"
      end
    end,
    mode = { "i", "n" },
    silent = true,
    expr = true,
    desc = "Scroll backward",
  },
}

return M
