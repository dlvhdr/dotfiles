local M = {}

local null_ls = require("null-ls")
local services = require("dlvhdr.plugins.lsp.servers.none-ls.services")

local alternative_methods = {
  null_ls.methods.DIAGNOSTICS,
  null_ls.methods.DIAGNOSTICS_ON_OPEN,
  null_ls.methods.DIAGNOSTICS_ON_SAVE,
}

function M.list_registered(filetype)
  local registered_providers = services.list_registered_providers_names(filetype)
  local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
    return registered_providers[m] or {}
  end, alternative_methods))

  providers_for_methods = vim.tbl_filter(function(provider)
    return provider ~= "codespell"
  end, providers_for_methods)

  return providers_for_methods
end

return M
