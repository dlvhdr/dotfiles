local M = {}

local lspconfig = require("lspconfig")

M.setup = function(opts)
  require("lspconfig").tsserver.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    root_dir = lspconfig.util.root_pattern("package.json"),
    settings = {
      typescript = {
        format = {
          indentSize = vim.o.shiftwidth,
          convertTabsToSpaces = vim.o.expandtab,
          tabSize = vim.o.tabstop,
        },
      },
      javascript = {
        format = {
          indentSize = vim.o.shiftwidth,
          convertTabsToSpaces = vim.o.expandtab,
          tabSize = vim.o.tabstop,
        },
      },
      completions = {
        completeFunctionCalls = true,
      },
    },
  })

  vim.keymap.set("n", "<leader>co", function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.removeUnused.ts" },
      },
    })

    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.addMissingImports" },
        diagnostics = {},
      },
    })
  end, { desc = "Organize Imports" })
end

return M
