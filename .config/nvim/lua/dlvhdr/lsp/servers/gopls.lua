local M = {}

M.setup = function(opts)
  require("lspconfig").gopls.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    cmd = { "gopls", "serve" },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        linksInHover = false,
        codelenses = {
          generate = true,
          gc_details = true,
          regenerate_cgo = true,
          tidy = true,
          upgrade_depdendency = true,
          vendor = true,
        },
        usePlaceholders = true,
      },
    },
  })
end

return M
