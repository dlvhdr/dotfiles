local M = {}

M.setup = function(opts)
  vim.lsp.config("gopls", {
    -- change to LspAttach autocmd
    on_attach = opts.on_attach,
    -- use opts.servers['*'].capabilities = vim.tbl_deep_extend('force', opts.servers['*'].capabilities or {}, capabilities)
    -- https://github.com/LazyVim/LazyVim/blob/c64a61734fc9d45470a72603395c02137802bc6f/lua/lazyvim/plugins/lsp/init.lua#L213
    capabilities = opts.capabilities,
  })
  vim.lsp.enable("gopls")
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function()
    local params = vim.lsp.util.make_range_params(nil, "utf-16")
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end,
})

return M
