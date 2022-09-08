local M = {}

local null_ls = require("null-ls")
local lspconfigUtils = require("lspconfig.util")
local utils = require("dlvhdr.utils")

M.has_eslint_config = function()
  return lspconfigUtils.root_pattern(".eslintrc", ".eslintrc.json", ".eslintrc.js")(vim.fn.getcwd()) ~= nil
end

M.prettier_eslint_check = function()
  local has_eslint = false
  local cwd = vim.fn.getcwd()

  if M.has_eslint_config() then
    has_eslint = true
  else
    local rootJsonPath = lspconfigUtils.root_pattern("package.json")(cwd)
    if rootJsonPath then
      local rootJson = utils.read_json(lspconfigUtils.path.join(rootJsonPath, "package.json"))
      if rootJson ~= nil and rootJson.eslintConfig ~= nil then
        has_eslint = true
      end
    end

    local ancestorJsonPath = lspconfigUtils.find_package_json_ancestor()
    if ancestorJsonPath then
      local localJson = utils.read_json(ancestorJsonPath)
      if localJson ~= nil and localJson.eslintConfig ~= nil then
        has_eslint = true
      end
    end
  end

  if has_eslint then
    local has_prettier_plugin = lspconfigUtils.root_pattern("node_modules/eslint-plugin-prettier/package.json")
    if has_prettier_plugin then
      return "eslint"
    end
  end

  return "prettier"
end

M.getJSFormatter = function()
  -- local formatter = prettier_eslint_check()
  local formatter = "prettier"

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
