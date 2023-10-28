local mini = {
  "echasnovski/mini.nvim",
  dependencies = {
    "folke/tokyonight.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  event = "BufReadPre",
}

function mini.comment()
  require("mini.comment").setup({
    hooks = {
      pre = function()
        require("ts_context_commentstring.internal").update_commentstring({})
      end,
    },
  })
end

function mini.jump()
  require("mini.jump").setup({})

  local theme = require("dlvhdr.plugins.theme")
  local colors = theme.colors()
  if not colors then
    return
  end
  vim.api.nvim_set_hl(0, "MiniJump", { bg = colors.bg_search, underdotted = true })
end

function mini.move()
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
end

function mini.surround()
  require("mini.surround").setup({})
end

function mini.config()
  mini.comment()
  mini.jump()
  mini.move()
  mini.surround()
end

return mini
