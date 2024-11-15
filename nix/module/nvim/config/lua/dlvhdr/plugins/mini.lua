local M = {
  "echasnovski/mini.nvim",
  version = false,
  dependencies = {
    "folke/tokyonight.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  event = "BufReadPre",
}

function M.config()
  local theme = require("dlvhdr.plugins.theme")
  local colors = theme.colors()
  if not colors then
    return
  end

  require("mini.comment").setup({
    options = {
      custom_commentstring = function()
        return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
      end,
    },
  })

  require("mini.jump").setup({})
  vim.api.nvim_set_hl(0, "MiniJump", { bg = colors.bg_search, underdotted = true })

  require("mini.move").setup({
    mappings = {
      left = "H",
      right = "L",
      down = "J",
      up = "K",
      line_left = "",
      line_right = "",
      line_down = "",
      line_up = "",
    },
  })
  require("mini.surround").setup({})

  require("mini.ai").setup({
    search_method = "cover_or_next",
  })
end

return M
