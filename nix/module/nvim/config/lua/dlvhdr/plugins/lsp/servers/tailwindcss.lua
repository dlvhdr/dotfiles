local M = {}

M.setup = function(opts)
  require("lspconfig").tailwindcss.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
  })
end

return M
