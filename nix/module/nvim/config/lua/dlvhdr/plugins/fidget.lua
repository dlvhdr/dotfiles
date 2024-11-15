return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  config = function()
    vim.api.nvim_set_hl(0, "FidgetTitle", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "FidgetTask", { bg = "NONE" })
    require("fidget").setup({
      progress = {
        display = {
          done_icon = "󰄬",
          done_ttl = 1,
          format_message = function(msg)
            return ""
          end,
          format_annote = function(msg)
            return ""
          end,
          format_group_name = function(msg)
            return ""
          end,
        },
        notification_group = function()
          return "some_lsp"
        end,
      },
      notification = {
        window = {
          align = "top",
          winblend = 0,
          x_padding = 2,
          y_padding = 0,
        },
        view = {
          group_separator = "",
          render_message = function(msg, cnt)
            return msg
          end,
        },
      },
      integration = {
        ["nvim-tree"] = {
          enable = true,
        },
      },
    })
  end,
}
