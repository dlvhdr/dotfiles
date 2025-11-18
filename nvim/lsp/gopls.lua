return {
  cmd = { "gopls", "serve" },
  cmd_env = { GOFUMPT_SPLIT_LONG_LINES = "on" },
  document_highlight = { enabled = false },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = vim.fs.root(0, { "go.work", "go.mod", ".git" }),
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules", "-vendor" },
      semanticTokens = true,
    },
  },
}
