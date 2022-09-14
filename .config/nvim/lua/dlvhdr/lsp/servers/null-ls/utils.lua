local M = {}

local null_ls = require("null-ls")
local lspconfigUtils = require("lspconfig.util")

M.has_eslint_config = function()
  return lspconfigUtils.root_pattern(".eslintrc", ".eslintrc.json", ".eslintrc.js")(vim.fn.getcwd()) ~= nil
end

M.prettier_eslint_check = function()
  local has_prettier_plugin = lspconfigUtils.root_pattern("node_modules/eslint-plugin-prettier/package.json")
  if has_prettier_plugin then
    return "eslint"
  end

  return "prettier"
end

M.getJSFormatter = function()
  local formatter = M.prettier_eslint_check()

  if formatter == "eslint" then
    return null_ls.builtins.formatting.eslint_d.with({})
  else
    -- return nil
    return null_ls.builtins.formatting.prettierd.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "yaml",
        "yml",
        -- "markdown",
        "graphql",
      },
    })
  end
end

return M
