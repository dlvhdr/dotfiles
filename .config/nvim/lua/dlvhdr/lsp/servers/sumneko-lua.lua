local M = {}

M.setup = function(opts)
  local luadev = require("lua-dev").setup({
    lspconfig = {
      on_attach = opts.on_attach,
    },
  })

  local lspconfig = require("lspconfig")
  lspconfig.sumneko_lua.setup(luadev)
end

return M
