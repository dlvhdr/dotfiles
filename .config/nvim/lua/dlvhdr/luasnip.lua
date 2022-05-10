local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local types = require("luasnip.util.types")

local snippet = luasnip.s
local insert_node = luasnip.insert_node

luasnip.config.set_config({
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,
  ext_opts = {
    [types.insertNode] = {
      active = {
        hl_group = "DiagnosticVirtualTextHint",
      },
      passive = {
        virt_text = { { " ", "DiagnosticVirtualTextHint" } },
      },
    },
  },
  region_check_events = "InsertEnter,CursorHold",
  delete_check_events = "TextChanged,InsertLeave",
})

luasnip.filetype_extend("typescriptreact", { "typescript" })

luasnip.add_snippets(nil, {
  lua = {
    snippet(
      { trig = "req", name = "require", dscr = "require statement" },
      fmt("local {} = require('{}')", { insert_node(1, "module"), rep(1) })
    ),
  },
  typescript = {
    snippet(
      { trig = "console-callout", name = "Console callout", dscr = "Print something that will stand-out" },
      fmt(
        [[
          console.log('=============================');
          console.log({});
          console.log('=============================')
        ]],
        { insert_node(1) }
      )
    ),
    snippet(
      { trig = "describe", name = "Jest describe clause" },
      fmt(
        [[
          describe("{}", () => {{
            it("should {}", () => {{}});
          }});
        ]],
        { insert_node(1), insert_node(2) }
      )
    ),
    snippet(
      { trig = "it", name = "Jest test" },
      fmt(
        [[
          it("should {}", () => {{
            {}
          }});
        ]],
        { insert_node(1), insert_node(2) }
      )
    ),
    snippet(
      { trig = "af", name = "Anonymous function" },
      fmt(
        [[
          const {} = () => {{
            {}
          }};
        ]],
        { insert_node(1, "functionName"), insert_node(2) }
      )
    ),
  },
  typescriptreact = {
    snippet(
      { trig = "rfc", name = "React functional component" },
      fmt(
        [[
          import React from 'react';

          const {} = (): JSX.Element => {{
            return (
              <div>
                {}
              </div>
            )
          }}
          
          export default {};
        ]],
        { insert_node(1, "Component"), rep(1), rep(1) }
      )
    ),
  },
})

vim.keymap.set("n", "<leader>s", "<cmd>source ~/.config/nvim/lua/dlvhdr/luasnip.lua<CR>", { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-l>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end, { silent = true })
