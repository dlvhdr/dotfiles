local M = {}

local lspconfig = require("lspconfig")

M.setup = function(opts)
  require("lspconfig").tsserver.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    root_dir = lspconfig.util.root_pattern("package.json"),
  })

  vim.keymap.set("n", "<leader>cr", function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.removeUnused.ts" },
        diagnostics = {},
      },
    })
  end, { desc = "Remove Unused Imports" })

  vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.addMissingImports" },
        diagnostics = {},
      },
    })
  end, { desc = "Add Missing Imports" })
end

return M
