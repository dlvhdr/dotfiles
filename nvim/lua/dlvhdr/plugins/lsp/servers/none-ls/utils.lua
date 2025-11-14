local M = {}

local null_ls = require("null-ls")
local lspconfigUtils = require("lspconfig.util")

M.has_eslint_prettier_plugin = function()
  local buf_path = vim.fn.expand("%:p")
  local nearest_package_json = lspconfigUtils.find_package_json_ancestor(buf_path)
  if nearest_package_json == nil then
    return false
  end

  local package_json_blob =
    table.concat(vim.fn.readfile(lspconfigUtils.path.join(nearest_package_json, "package.json")))
  local package_json = vim.json.decode(package_json_blob)
  if package_json == nil then
    return false
  end

  if package_json == nil or package_json["devDependencies"] == nil then
    return false
  end
  local dev_deps = package_json["devDependencies"]
  return dev_deps["eslint-plugin-prettier"] ~= nil or dev_deps["@wix/eslint-plugin-cloud-runtime"] ~= nil
end

M.has_eslint_config = function()
  local nearest_package_json = lspconfigUtils.find_package_json_ancestor(vim.fn.expand("%:p"))
  if nearest_package_json == nil then
    return false
  end
  return lspconfigUtils.root_pattern(".eslintrc", ".eslintrc.json", ".eslintrc.js", "eslint.config.mjs")(
    nearest_package_json
  ) ~= nil
end

return M
