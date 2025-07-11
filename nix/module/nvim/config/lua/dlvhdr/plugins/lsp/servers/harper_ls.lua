local M = {}

local lspconfig = require("lspconfig")

M.setup = function(opts)
  lspconfig.harper_ls.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    settings = {
      ["harper-ls"] = {
        markdown = {
          IgnoreLinkTitle = true,
        },
      },
    },
  })
end

return M
