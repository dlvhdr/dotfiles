local M = {}

M.setup = function(opts)
  local lspconfig = require("lspconfig")
  lspconfig.kulala_ls.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
  })
end

return M
