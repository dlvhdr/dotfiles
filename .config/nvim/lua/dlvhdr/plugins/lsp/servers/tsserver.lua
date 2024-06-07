local M = {}

local lspconfig = require("lspconfig")

M.setup = function(opts)
  require("lspconfig").tsserver.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    root_dir = lspconfig.util.root_pattern("package.json"),
    init_options = {
      plugins = {
        {
          name = "@styled/typescript-styled-plugin",
          location = vim.env.XDG_DATA_HOME .. "/npm/lib/node_modules/@styled/typescript-styled-plugin",
        },
      },
    },
    settings = {
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        },
        format = {
          indentSize = vim.o.shiftwidth,
          convertTabsToSpaces = vim.o.expandtab,
          tabSize = vim.o.tabstop,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        },
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

  vim.keymap.set("n", "<leader>lo", function()
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
