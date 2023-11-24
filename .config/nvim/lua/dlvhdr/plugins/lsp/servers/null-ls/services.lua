local M = {}

function M.list_registered_providers_names(filetype)
  local s = require("null-ls.sources")
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      local source_name = source.name
      if source.name == "eslint_d" then
        source_name = "󰱺"
      end
      if source.name == "copilot" then
        source_name = ""
      end
      if source.name == "prettierd" then
        source_name = "󰄭"
      end
      table.insert(registered[method], source_name)
    end
  end
  return registered
end

return M
