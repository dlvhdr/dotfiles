local M = {}

local lspconfig = require("lspconfig")

M.setup = function(opts)
  lspconfig.jsonls.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
    end,
    settings = {
      json = {
        format = {
          enable = true,
        },
        validate = { enable = true },
      },
    },
  })
end

return M
