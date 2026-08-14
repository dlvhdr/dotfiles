-- TS7 currently registers an ancestor-wide **/* watcher that exhausts
-- Neovim's per-directory kqueue watchers on macOS.
---@type vim.lsp.Config
return {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = false,
      },
    },
  },
}
