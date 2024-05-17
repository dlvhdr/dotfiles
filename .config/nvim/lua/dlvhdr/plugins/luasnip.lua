local M = {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  version = "v2.*",
  build = "make install_jsregexp",
  keys = {
    {
      "<tab>",
      function()
        return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
      end,
      expr = true,
      silent = true,
      mode = "i",
    },
    {
      "<tab>",
      function()
        require("luasnip").jump(1)
      end,
      mode = "s",
    },
    {
      "<s-tab>",
      function()
        require("luasnip").jump(-1)
      end,
      mode = { "i", "s" },
    },
  },
}

M.config = function()
  local status_ok, luasnip = pcall(require, "luasnip")
  if not status_ok then
    return
  end

  local types = require("luasnip.util.types")

  -- luasnip.cleanup()

  luasnip.config.set_config({
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = true,

    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",

    -- Autosnippets:
    delete_check_events = "TextChanged",

    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "  ^l", "TSWarning" } },
        },
      },
      [types.insertNode] = {
        active = {
          hl_group = "None",
        },
        passive = {
          hl_group = "None",
        },
      },
    },
  })

  luasnip.filetype_extend("typescriptreact", { "typescript" })

  require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/dlvhdr/snippets" } })
  require("luasnip.loaders.from_vscode").lazy_load()

  -- vim.keymap.set("n", "<leader>s", function()
  --   vim.cmd([[luafile $XDG_CONFIG_HOME/nvim/lua/dlvhdr/luasnip.lua]])
  --   vim.notify("Reloaded snippets!", "info")
  -- end, { silent = true })
end

return M
