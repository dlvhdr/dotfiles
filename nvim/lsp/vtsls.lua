return {
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = false,
        },
      },
    },
    typescript = {
      tsserver = {
        maxTsServerMemory = 8192,
        nodePath = "node",
      },
      preferences = {
        autoImportFileExcludePatterns = {
          "**/lodash/**",
          "**/process/**",
          "**/events/**",
          "date-fns",
          "date-fns/esm",
        },
      },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
    },
    javascript = {
      tsserver = {
        maxTsServerMemory = 8192,
        nodePath = "node",
      },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}
