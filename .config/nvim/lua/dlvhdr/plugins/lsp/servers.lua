local handlers = require("dlvhdr.plugins.lsp.handlers")
local lspconfig = require("lspconfig")
local opts = {
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
}

lspconfig.denols.setup({
  on_attach = opts.on_attach,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
})
lspconfig.html.setup(opts)
require("dlvhdr.plugins.lsp.servers.tsserver").setup(opts)
require("dlvhdr.plugins.lsp.servers.jsonls").setup(opts)
require("dlvhdr.plugins.lsp.servers.null-ls").setup(opts)
require("dlvhdr.plugins.lsp.servers.gopls").setup(opts)
require("dlvhdr.plugins.lsp.servers.lua_ls").setup(opts)
require("dlvhdr.plugins.lsp.servers.emmet-ls").setup(opts)
require("dlvhdr.plugins.lsp.servers.docker-langserver").setup(opts)
require("dlvhdr.plugins.lsp.servers.yamlls").setup(opts)
