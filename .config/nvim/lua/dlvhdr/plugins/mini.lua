local mini = {
  "echasnovski/mini.nvim",
  dependencies = {
    "folke/tokyonight.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  event = "VeryLazy",
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

function mini.config()
  mini.comment()
  mini.jump()
end

return mini
