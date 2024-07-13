local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local snippet = luasnip.s
local snippet_node = luasnip.snippet_node
local insert_node = luasnip.insert_node
local function_node = luasnip.function_node
local choice_node = luasnip.choice_node
local types = require("luasnip.util.types")

return {
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
  snippet(
    {
      trig = "sx",
      name = "MUI styles",
      desc = "Insert MUI styles prop",
    },
    fmt([[sx={{ <> }}]], {
      insert_node(1),
    }, { delimiters = "<>" })
  ),
  snippet(
    {
      trig = "terenary",
      name = "React null terenary",
      desc = "React null terenary",
    },
    choice_node(1, {
      snippet_node(
        nil,
        fmt([[{<> ? (<>) : null}]], {
          insert_node(1, { "cond" }),
          insert_node(2, { "true" }),
        }, { delimiters = "<>" })
      ),
      snippet_node(
        nil,
        fmt([[{!<> ? null : (<>)}]], {
          insert_node(1, { "cond" }),
          insert_node(2, { "false" }),
        }, { delimiters = "<>" })
      ),
    })
  ),
  snippet(
    {
      trig = "flex",
      name = "MUI Flex Box",
      desc = "MUI Flex Box",
    },
    fmt(
      [[
        <Box display="flex" flexDirection="row" alignItems="center">
          {}
        </Box>
      ]],
      {
        insert_node(1),
      }
    )
  ),
}
