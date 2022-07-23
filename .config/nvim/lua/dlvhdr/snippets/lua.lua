local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippet = luasnip.s
local insert_node = luasnip.insert_node

return {
  snippet(
    { trig = "req", name = "require", dscr = "require statement" },
    fmt("local {} = require('{}')", { insert_node(1, "module"), rep(1) })
  ),
}
