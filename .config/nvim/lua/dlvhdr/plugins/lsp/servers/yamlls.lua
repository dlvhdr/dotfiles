local M = {}

local lspconfig = require("lspconfig")

M.setup = function(opts)
  lspconfig.yamlls.setup({
    capabilities = opts.capabilities,
    on_attach = opts.on_attach,
    settings = {
      yaml = {
        schemaStore = {
          url = "https://www.schemastore.org/api/json/catalog.json",
          enable = true,
        },
        hover = true,
      },
    },
  })
end

return M
