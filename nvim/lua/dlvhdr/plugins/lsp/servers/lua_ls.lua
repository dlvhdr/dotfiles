local M = {}

M.setup = function(opts)
  local lspconfig = require("lspconfig")
  lspconfig.lua_ls.setup({
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
