local status_ok, msi = pcall(require, "mason-tool-installer")
if not status_ok then
  return
end

msi.setup({
  ensure_installed = {

    -- NullLS
    "golangci-lint",
    "eslint_d",
    "prettierd",
    "shellcheck",

    -- LSP
    "typescript-language-server",
    "bash-language-server",
    "lua-language-server",
    "gopls",
    "stylua",
  },
  auto_update = false,
  run_on_start = true,
  start_delay = 5000,
})
