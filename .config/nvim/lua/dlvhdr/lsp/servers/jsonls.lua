local M = {}

local lspconfig = require("lspconfig")

M.setup = function(opts)
  lspconfig.jsonls.setup({
    cmd = { "vscode-json-languageserver", "--stdio" },
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    filetypes = { "json", "jsonc" },
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })
end

return M
