local M = {}

---When typing "await" add "async" to the function declaration if the function
---isn't async already.
function M.add_async()
  -- This function should be executed when the user types "t" in insert mode,
  -- but "t" is not inserted because it's the trigger.
  vim.api.nvim_feedkeys("t", "n", true)

  local text_before_cursor = vim.fn.getline("."):sub(vim.fn.col(".") - 4, vim.fn.col(".") - 1)
  if text_before_cursor ~= "awai" then
    return
  end

  local current_node = vim.treesitter.get_node({ ignore_injections = false })
  local function_node = require("dlvhdr.utils.treesitter").find_node_ancestor(
    { "arrow_function", "function_declaration", "function" },
    current_node
  )
  if not function_node then
    return
  end

  local function_text = vim.treesitter.get_node_text(function_node, 0)
  if vim.startswith(function_text, "async ") then
    return
  end

  local start_row, start_col = function_node:start()
  vim.api.nvim_buf_set_text(0, start_row, start_col, start_row, start_col, { "async " })
end

function M.goto_exported_symbol()
  local current_node = vim.treesitter.get_node({ ignore_injections = false })
  if not current_node then
    vim.notify("No current node", vim.log.levels.ERROR)
    return
  end
  local language_tree = require("dlvhdr.utils.treesitter").get_language_tree_for_cursor_location()
  local language = language_tree._lang
  vim.print(language)

  local query = vim.treesitter.query.parse(
    language,
    [[
      [
        (export_statement
          (declaration
            [
              (type_identifier) @name
              (identifier) @name
            ]
          )
        )
        (method_definition
          (accessibility_modifier)
          (property_identifier) @name
        )
      ]
    ]]
  )
  -- ((export_statement) @export
  --   (#contains? @export "export default")
  -- )

  while current_node:parent() do
    current_node = current_node:parent()
    vim.print("wat", vim.treesitter.get_node_text(current_node, 0))
    local pos = current_node:start()
    for _, node, _, _ in query:iter_captures(current_node, 0, nil, pos + 1) do
      local row1, col1 = node:range()
      vim.api.nvim_win_set_cursor(0, { row1 + 1, col1 })
      return
    end
  end
end

return M
