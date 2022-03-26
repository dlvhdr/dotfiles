local M = {}

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

M.setup = function(opts)
  if not configs.ls_emmet then
    configs.ls_emmet = {
      default_config = {
        cmd = { "ls_emmet", "--stdio" },
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "haml",
          "xml",
          "xsl",
          "pug",
          "slim",
          "sass",
          "stylus",
          "less",
          "sss",
        },
        root_dir = function(fname)
          return vim.loop.cwd()
        end,
        settings = {},
      },
    }
  end

  lspconfig.ls_emmet.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
  })
end

return M
