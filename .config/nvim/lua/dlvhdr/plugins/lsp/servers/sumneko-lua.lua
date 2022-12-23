local M = {}

M.setup = function()
  require("neodev").setup({})

  local lspconfig = require("lspconfig")
  lspconfig.sumneko_lua.setup({
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
