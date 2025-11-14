local M = {}

local lspconfig = require("lspconfig")

M.setup = function(opts)
  lspconfig.dockerls.setup({
    name = "docker-langserver",
    language = "dockerfile",
    file_patterns = { "Dockerfile$" },
    command = { "docker-langserver", "--stdio" },
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
  })
end

return M
