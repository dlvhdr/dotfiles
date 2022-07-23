local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippet = luasnip.s
local insert_node = luasnip.insert_node
local choice_node = luasnip.choice_node
local snippet_node = luasnip.snippet_node
local text_node = luasnip.text_node

return {
  snippet(
    {
      trig = "im",
      name = "import",
      dscr = "import a component/function from a package",
    },
    fmt([[import {name} from '{path}']], {
      path = insert_node(1),
      name = choice_node(2, {
        snippet_node(nil, { text_node("{ "), insert_node(1), text_node(" }") }),
        insert_node(nil),
      }),
    })
  ),
  snippet(
    { trig = "cl", name = "console.log", dscr = "Log a variable" },
    fmt('console.log("{}", {});', { insert_node(1), rep(1) })
  ),
  snippet(
    { trig = "console-callout", name = "Console callout", dscr = "Print something that will stand-out" },
    fmt(
      [[
          console.log('=============================');
          console.log("{}", {});
          console.log('=============================')
        ]],
      { insert_node(1), rep(1) }
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
          {}const {} = ({}) => {{
            {}
          }};
        ]],
      {
        choice_node(1, { text_node(""), text_node("export ") }),
        insert_node(2, { "functionName" }),
        insert_node(3),
        insert_node(4),
      }
    )
  ),
}
