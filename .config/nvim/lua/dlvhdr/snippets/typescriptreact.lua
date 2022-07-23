local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippet = luasnip.s
local insert_node = luasnip.insert_node
local function_node = luasnip.function_node

return {
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
  snippet(
    {
      trig = "us",
      name = "useState",
      desc = "useState with type annotation",
    },
    fmt([[const [{state}, {setState}] = useState({initial_value})]], {
      state = insert_node(1),
      setState = function_node(function(args)
        if args[1][1]:len() > 0 then
          return "set" .. args[1][1]:sub(1, 1):upper() .. args[1][1]:sub(2)
        else
          return ""
        end
      end, 1),
      initial_value = insert_node(0),
    })
  ),
  snippet(
    {
      trig = "ue",
      name = "useEffect",
      desc = "useEffect",
    },
    fmt(
      [[
          useEffect(() => {{
            {body}
          }}, [{deps}])
        ]],
      {
        body = insert_node(0),
        deps = insert_node(1),
      }
    )
  ),
  snippet(
    {
      trig = "cn",
      name = "className",
      desc = "Insert className attribute",
    },
    fmt([[className={{{}}}]], {
      insert_node(0),
    })
  ),
}
