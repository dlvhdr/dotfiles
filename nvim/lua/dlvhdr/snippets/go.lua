local ts_locals_ok, ts_locals = pcall(require, "nvim-treesitter.locals")
if not ts_locals_ok then
  return
end
local ts_utils_ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
if not ts_utils_ok then
  return
end

local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local snippet = luasnip.s
local insert_node = luasnip.insert_node
local function_node = luasnip.function_node
local choice_node = luasnip.choice_node
local snippet_node = luasnip.snippet_node
local text_node = luasnip.text_node
local dynamic_node = luasnip.dynamic_node

local get_node_text = vim.treesitter.get_node_text
local transform = function(text, info)
  if text == "int" then
    return text_node("0")
  elseif text == "error" then
    if info then
      info.index = info.index + 1
      return choice_node(1, {
        text_node(info.err_name),
        snippet_node(
          nil,
          fmt('errors.Wrap({err_name}, "{func_name}")', {
            err_name = text_node(info.err_name),
            func_name = insert_node(1, { info.func_name }),
          })
        ),
      })
    else
      return text_node("err")
    end
  elseif text == "bool" then
    return text_node("false")
  elseif text == "string" then
    return text_node('""')
  else
    return text_node("nil")
  end

  return text_node(text)
end

local handlers = {
  ["parameter_list"] = function(node, info)
    local result = {}

    local count = node:named_child_count()
    for idx = 0, count - 1 do
      local transformed_node = transform(get_node_text(node:named_child(idx), 0), info)
      table.insert(result, transformed_node)
      if idx ~= count - 1 then
        table.insert(result, text_node({ ", " }))
      end
    end

    return result
  end,
  ["type_identifier"] = function(node, info)
    local text = get_node_text(node, 0)
    return { transform(text, info) }
  end,
}

local function go_result_type(info)
  local cursor_node = ts_utils.get_node_at_cursor(0, true)
  if cursor_node == nil then
    return {}
  end
  local scope_tree = ts_locals.get_scope_tree(cursor_node, 0)

  local fn
  for _, v in ipairs(scope_tree) do
    if v:type() == "function_declaration" or v:type() == "method_declaration" or v:type() == "func_literal" then
      fn = v
      break
    end
  end

  if fn == nil then
    return {}
  end

  local query = vim.treesitter.get_query("go", "LuaSnip_Result")
  for _, node in query:iter_captures(fn, 0) do
    if handlers[node:type()] then
      return handlers[node:type()](node, info)
    end
  end
end

local go_ret_vals = function(args)
  if args[2] == nil then -- inline error handling
    return snippet_node(
      args[1],
      go_result_type({
        index = 0,
        err_name = "err",
        func_name = "Wrap",
      })
    )
  end
  return snippet_node(
    nil,
    go_result_type({
      index = 0,
      err_name = args[1][1],
      func_name = args[2][1],
    })
  )
end

local same = function(index)
  return function_node(function(args)
    return args[1]
  end, { index })
end

vim.treesitter.query.set(
  "go",
  "LuaSnip_Result",
  [[
  [
    (method_declaration result: (_) @id)
    (function_declaration result: (_) @id)
    (func_literal result: (_) @id)
  ]
]]
)

return {
  snippet("ef", {
    insert_node(1, { "val" }),
    text_node(", err := "),
    insert_node(2, { "f" }),
    text_node("("),
    insert_node(3),
    text_node(")"),
    insert_node(0),
  }),
  -- TODO: fix
  -- snippet("iferr", {
  --   text_node({ "if err != nil {", "\treturn " }),
  --   go_ret_vals({ 1, nil }),
  --   text_node({ "", "}" }),
  --   insert_node(0),
  -- }),
  snippet("errval", {
    insert_node(1, { "val" }),
    text_node(", "),
    insert_node(2, { "err" }),
    text_node(" := "),
    insert_node(3, { "f" }),
    text_node("()"),
    text_node({ "", "if " }),
    same(2),
    text_node({ " != nil {", "\treturn " }),
    dynamic_node(4, go_ret_vals, { 2, 3 }),
    text_node({ "", "}" }),
    insert_node(0),
  }),
  snippet(
    { trig = "test", name = "Go test", desc = "Create a Go test" },
    fmt(
      [[
func Test_<>(t *testing.T) {
	testEngine, qr := component.Setup(t)

	ctx := kcontext.GetTestContext(tu.TEST_ACCOUNT_ID)
	fake<> := generateFake<>()

	tests := []struct {
		name string
		want *<>
		code int
	}{
		{
			name: "A Workspace",
			want: <>
			code: http.StatusOK,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			tu.InsertModelsToDB(t, qr.Qr.GetDb(), []db.<>{})

			defaultClaims := &jwt.RawHasuraClaims{KomodorRole: common.KomodorRoleAccountAdmin, AccountID: tu.TEST_ACCOUNT_ID}
			token, _ := tu.SetupTokenAndMockJwksServer(defaultClaims)
			claims, _ := jwt.ParseJWT(token)
			tu.MockAuthApiInternalAuthorization(&claims.RawHasuraClaims, nil)
			path := fmt.Sprintf("%s%s", api.GroupAPI, "/<>")

			w := tu.MakeRequestWithHeaders(testEngine, http.MethodPut, path, map[string]string{"Authorization": token}, workspacesapi.ConvertAppViewToWorkspace(ctx, tt.updatedAppView, true))
			assert.Equal(t, tt.code, w.Code)
			parsedRes := tu.GetResponseFor[<>](t, w)
			assert.EqualValues(t, tt.want, *parsedRes)
		})
	}
}

func generateFake<>(size int) []<> {
	data := make([]<>, size)
	for i := 0; i << size; i++ {
		var item <>
		gofakeit.Struct(&item)
	}
	return data
}
  ]],
      {
        insert_node(1),
        insert_node(2),
        insert_node(3),
        insert_node(4),
        insert_node(5),
        insert_node(6),
        insert_node(7),
        insert_node(8),
        insert_node(9),
        insert_node(10),
        insert_node(11),
        insert_node(12),
      },
      { delimiters = "<>" }
    )
  ),
}
