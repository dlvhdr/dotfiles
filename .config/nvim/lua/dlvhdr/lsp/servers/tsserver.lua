local M = {}

local lspconfig = require("lspconfig")

M.setup = function(opts)
  require("lspconfig").tsserver.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    root_dir = lspconfig.util.root_pattern("package.json"),
  })
end

return M
