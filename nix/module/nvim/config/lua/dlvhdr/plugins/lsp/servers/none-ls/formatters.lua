local M = {}

local null_ls = require("null-ls")
local services = require("dlvhdr.plugins.lsp.servers.none-ls.services")

local method = null_ls.methods.FORMATTING

function M.list_registered(filetype)
  local registered_providers = services.list_registered_providers_names(filetype)
  return registered_providers[method] or {}
end

return M
