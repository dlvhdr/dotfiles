local M = {}

local null_ls = require("null-ls")
local lspconfigUtils = require("lspconfig.util")
local utils = require("dlvhdr.lsp.servers.null-ls.utils")

M.setup = function(opts)
  null_ls.setup({
    on_attach = opts.on_attach,
    root_dir = lspconfigUtils.root_pattern(".git"),
    sources = {
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.shellcheck.with({ filetypes = { "sh" } }),
      null_ls.builtins.formatting.stylua.with({
        condition = function()
          return lspconfigUtils.root_pattern("stylua.toml")
        end,
      }),
      utils.getJSFormatter,
      null_ls.builtins.diagnostics.eslint_d.with({
        condition = function()
          local has = utils.has_eslint_config()
          return has
        end,
      }),
    },
  })
end

return M
