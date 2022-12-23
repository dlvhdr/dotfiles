local M = {}

local lspconfig = require("lspconfig")

M.setup = function(opts)
  lspconfig.emmet_ls.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
  })
end

return M
