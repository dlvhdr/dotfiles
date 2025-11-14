local M = {}

local lspconfig = require("lspconfig")
M.setup = function(opts)
  lspconfig.astro.setup({
    pattern = { "*.mdx", "*.astro" },
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    init_options = {
      typescript = {
        tsdk = "/opt/homebrew/lib/node_modules/typescript/lib",
      },
    },
  })
end

return M
