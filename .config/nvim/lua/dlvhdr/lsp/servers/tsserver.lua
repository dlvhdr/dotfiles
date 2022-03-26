local M = {}

M.setup = function(opts)
  require("lspconfig").tsserver.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
  })
end

return M
