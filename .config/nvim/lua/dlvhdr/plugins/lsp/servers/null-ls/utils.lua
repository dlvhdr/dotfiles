local M = {}

local null_ls = require("null-ls")
local lspconfigUtils = require("lspconfig.util")

M.has_eslint_prettier_plugin = function()
  local buf_path = vim.fn.expand("%:p")
  local nearest_package_json = lspconfigUtils.find_package_json_ancestor(buf_path)

  local package_json_blob =
    table.concat(vim.fn.readfile(lspconfigUtils.path.join(nearest_package_json, "package.json")))
  local package_json = vim.json.decode(package_json_blob)
  if package_json == nil then
    return false
  end

  local dev_deps = package_json["devDependencies"]
  return dev_deps["eslint-plugin-prettier"] ~= nil or dev_deps["@wix/eslint-plugin-cloud-runtime"] ~= nil
end

M.has_eslint_config = function()
  local nearest_package_json = lspconfigUtils.find_package_json_ancestor(vim.fn.expand("%:p"))
  return lspconfigUtils.root_pattern(".eslintrc", ".eslintrc.json", ".eslintrc.js")(nearest_package_json) ~= nil
end

M.prettier_eslint_check = function()
  local has_prettier_plugin = lspconfigUtils.root_pattern("node_modules/eslint-plugin-prettier/package.json")(".git")
  if has_prettier_plugin ~= nil then
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
