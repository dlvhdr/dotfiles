local M = {}

M.setup = function()
  local handlers = require("dlvhdr.plugins.lsp.handlers")
  local lspconfig = require("lspconfig")

  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities(),
  }

  -- lspconfig.denols.setup({
  --   on_attach = opts.on_attach,
  --   root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  -- })
  lspconfig.html.setup(opts)
  require("dlvhdr.plugins.lsp.servers.vtsls").setup(opts)
  require("dlvhdr.plugins.lsp.servers.jsonls").setup(opts)
  require("dlvhdr.plugins.lsp.servers.none-ls").setup(opts)
  require("dlvhdr.plugins.lsp.servers.gopls").setup(opts)
  require("dlvhdr.plugins.lsp.servers.lua_ls").setup(opts)
  require("dlvhdr.plugins.lsp.servers.docker-langserver").setup(opts)
  require("dlvhdr.plugins.lsp.servers.yamlls").setup(opts)
  require("dlvhdr.plugins.lsp.servers.pyright").setup(opts)
  require("dlvhdr.plugins.lsp.servers.helm-ls").setup()
  require("dlvhdr.plugins.lsp.servers.bashls").setup()
  require("dlvhdr.plugins.lsp.servers.nixd").setup(opts)
  require("dlvhdr.plugins.lsp.servers.harper_ls").setup(opts)
end

return M
