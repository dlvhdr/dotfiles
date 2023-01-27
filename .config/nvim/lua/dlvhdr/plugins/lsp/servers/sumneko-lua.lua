local M = {}

M.setup = function(opts)
  require("neodev").setup({})

  local lspconfig = require("lspconfig")
  lspconfig.sumneko_lua.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
end

return M
