local luasnip = require("luasnip")
local types = require("luasnip.util.types")
local snippets = require("dlvhdr.snippets")

-- luasnip.cleanup()

luasnip.config.set_config({
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,
  region_check_events = "InsertEnter,CursorHold",
  delete_check_events = "TextChanged,InsertLeave",

  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "  ^l", "TSWarning" } },
      },
    },
    [types.insertNode] = {
      active = {
        hl_group = "None",
        virt_text = { { "←^j ● ^k→", "DiagnosticVirtualTextHint" } },
      },
      passive = {
        hl_group = "None",
      },
      snippet_passive = {
        virt_text = { { "●", "mkdCodeEnd" } },
      },
    },
  },
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 300,
  -- minimal increase in priority.
  ext_prio_increase = 1,
})

luasnip.filetype_extend("typescriptreact", { "typescript" })

luasnip.add_snippets(nil, snippets)

vim.keymap.set("n", "<leader>s", function()
  vim.cmd([[luafile $XDG_CONFIG_HOME/nvim/lua/dlvhdr/luasnip.lua]])
  vim.notify("Reloaded snippets!", "info")
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-l>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end, { silent = true })
