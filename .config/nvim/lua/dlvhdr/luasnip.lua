local luasnip = require("luasnip")

luasnip.config.set_config({
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,
})

local snippet = luasnip.s
local fmt = require("luasnip.extras.fmt").fmt
local insert_node = luasnip.insert_node
local rep = require("luasnip.extras").rep

-- luasnip.filetype_extend("typescript", { "javascript" })
luasnip.filetype_extend("typescriptreact", { "typescript" })

luasnip.snippets = {
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
                Component
              </div>
            )
          }}
          
          export default {}
        ]],
        { insert_node(1, "Component"), rep(1) }
      )
    ),
  },
}

-- require("luasnip.loaders.from_vscode").load({
--   paths = vim.fn.stdpath("config") .. "/snippets",
-- })

-- vim.api.nvim_set_keymap(
--   "i",
--   "<C-m>",
--   [[:lua function()
--   if luasnip.expand_or_jumpable() then
--     luasnip.expand_or_jump()
--   end
-- end]],
--   { silent = true }
-- )

vim.api.nvim_set_keymap(
  "n",
  "<leader>s",
  "<cmd>source ~/.config/nvim/lua/dlvhdr/luasnip.lua<CR>",
  { noremap = true, silent = true }
)
