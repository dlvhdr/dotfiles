local M = {}

local lspconfig = require("lspconfig")

M.setup = function()
  lspconfig.helm_ls.setup({
    settings = {
      ["helm-ls"] = {
        yamlls = {
          path = "yaml-language-server",
        },
      },
    },
  })
end

return M
