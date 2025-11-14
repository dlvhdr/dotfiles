local M = {
  "nvim-mini/mini.nvim",
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
  vim.api.nvim_set_hl(0, "MiniJump", { bg = colors.bg_search })

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

  local spec_treesitter = require("mini.ai").gen_spec.treesitter
  require("mini.ai").setup({
    n_lines = 500,
    search_method = "cover_or_next",
    custom_textobjects = {
      F = spec_treesitter({ a = "@function_declaration.outer", i = "@function_declaration.inner" }),
    },
    o = spec_treesitter({ -- code block
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }),
    f = spec_treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
  })

  -- require("mini.pairs").setup({
  --   modes = { insert = true, command = true, terminal = false },
  --   -- skip autopair when next character is one of these
  --   skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  --   -- skip autopair when the cursor is inside these treesitter nodes
  --   skip_ts = { "string" },
  --   -- skip autopair when next character is closing pair
  --   -- and there are more closing pairs than opening pairs
  --   skip_unbalanced = true,
  --   -- better deal with markdown code blocks
  --   markdown = true,
  -- })
end

return M
