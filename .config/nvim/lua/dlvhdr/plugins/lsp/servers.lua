local M = {}

M.setup = function()
  local handlers = require("dlvhdr.plugins.lsp.handlers")
  local lspconfig = require("lspconfig")

  local lsp_status = require("lsp-status")
  lsp_status.register_progress()
  lsp_status.config({
    status_symbol = "✔︎",
  })

  local capabilities = vim.tbl_extend("keep", handlers.capabilities or {}, lsp_status.capabilities)

  local opts = {
    on_attach = handlers.on_attach,
    capabilities = capabilities,
  }

  lspconfig.denols.setup({
    on_attach = opts.on_attach,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  })
  lspconfig.html.setup(opts)
  require("dlvhdr.plugins.lsp.servers.tsserver").setup(opts)
  require("dlvhdr.plugins.lsp.servers.jsonls").setup(opts)
  require("dlvhdr.plugins.lsp.servers.none-ls").setup(opts)
  require("dlvhdr.plugins.lsp.servers.gopls").setup(opts)
  require("dlvhdr.plugins.lsp.servers.lua_ls").setup(opts)
  -- require("dlvhdr.plugins.lsp.servers.emmet-ls").setup(opts)
  require("dlvhdr.plugins.lsp.servers.docker-langserver").setup(opts)
  require("dlvhdr.plugins.lsp.servers.yamlls").setup(opts)
end

return M
