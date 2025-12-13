local M = {}

M.setup = function()
  local handlers = require("dlvhdr.plugins.lsp.handlers")

  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities(),
  }

  -- require("dlvhdr.plugins.lsp.servers.vtsls").setup(opts)
  require("dlvhdr.plugins.lsp.servers.none-ls").setup(opts)
  vim.lsp.enable("kulala_ls") -- brew install kulala-ls
  vim.lsp.enable("vtsls")
  vim.lsp.enable("astro")
  vim.lsp.enable("pyright")
  vim.lsp.enable("dockerls") -- npm install -g dockerfile-language-server-nodejs
  vim.lsp.enable("lua_ls") -- brew install lua-language-server
  vim.lsp.enable("jsonls") -- brew install vscode-langservers-extracted
  vim.lsp.enable("yamlls") -- npm i -g add yaml-language-server
  vim.lsp.enable("prismals") -- npm install -g @prisma/language-server
  vim.lsp.enable("html") -- brew install vscode-langservers-extracted
  vim.lsp.enable("gopls") -- brew install gopls
  vim.lsp.enable("bashls") -- npm i -g bash-language-server
  vim.lsp.enable("helm_ls") -- brew install helm-ls
  vim.lsp.config("harper_ls", { filetypes = { "markdown" } })
  vim.lsp.enable("harper_ls")
  vim.lsp.enable("tailwindcss")
  -- vim.lsp.enable("denols")
  -- require("dlvhdr.plugins.lsp.servers.nixd").setup(opts)

  vim.lsp.config("*", {
    capabilities = handlers.capabilities(),
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      handlers.on_attach(client, event.buf)

      if client ~= nil and client.name == "gopls" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = { "*.go" },
          callback = function()
            local params = vim.lsp.util.make_range_params(nil, "utf-16")
            ---@diagnostic disable-next-line: inject-field
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
      end
    end,
  })
end

return M
