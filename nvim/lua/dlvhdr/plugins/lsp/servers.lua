local M = {}

M.setup = function()
  local handlers = require("dlvhdr.plugins.lsp.handlers")

  vim.lsp.enable("kulala_ls") -- brew install kulala-ls
  -- vim.lsp.enable("vtsls")
  vim.lsp.enable("tsc")
  vim.lsp.enable("astro")
  vim.lsp.enable("pyright")
  vim.lsp.enable("dockerls") -- npm install -g dockerfile-language-server-nodejs
  vim.lsp.enable("lua_ls") -- brew install lua-language-server
  -- vim.lsp.enable("jsonls") -- brew install vscode-langservers-extracted
  vim.lsp.enable("yamlls") -- npm i -g add yaml-language-server
  vim.lsp.enable("golangci_lint_ls")
  vim.lsp.enable("prismals") -- npm install -g @prisma/language-server
  vim.lsp.enable("html") -- brew install vscode-langservers-extracted
  vim.lsp.enable("gopls") -- brew install gopls
  vim.lsp.enable("bash") -- npm i -g bash-language-server
  -- vim.lsp.enable("shfmt") -- go install mvdan.cc/sh/v3/cmd/shfmt@latest
  vim.lsp.enable("helm_ls") -- brew install helm-ls
  vim.lsp.config("harper_ls", { filetypes = { "markdown" } })
  vim.lsp.enable("tailwindcss") -- brew install tailwindcss-language-server

  -- For some reason putting this in ~/.config/nvim/lsp/oxlint.lua doesn't override
  --  the config from lspconfig - which doesn't work for monorepos with a globally installed oxlint.
  -- See https://github.com/neovim/nvim-lspconfig/issues/4432
  -- I had to override both cmd and root_dir here.
  vim.lsp.config("oxlint", {
    settings = {
      fixKind = "all",
      typeAware = false,
    },
    cmd = function(dispatchers, config)
      local cmd = "oxlint"
      if (config or {}).root_dir then
        local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
        if vim.fn.executable(local_cmd) == 1 then
          cmd = local_cmd
        end
      end
      return vim.lsp.rpc.start({ cmd, "--lsp" }, dispatchers)
    end,
    root_dir = function(bufnr, on_dir)
      local cmd = "oxlint"
      local fname = vim.api.nvim_buf_get_name(bufnr)

      local root_markers = require("lspconfig.util").insert_package_json(
        { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" },
        { "oxlint", "vite%-plus" },
        fname
      )

      root_markers =
        require("lspconfig.util").root_markers_with_field(root_markers, { "vite.config.ts" }, "vite%-plus", fname)

      local dirs = vim.fs.find(root_markers, { path = fname, upward = true, limit = 3 })

      local root_dir = vim.fs.dirname(dirs[1])
      local local_cmd = vim.fs.joinpath(root_dir, "node_modules/.bin", cmd)

      if vim.fn.executable(local_cmd) == 1 then
        on_dir(root_dir)
        return
      end

      for i = 2, #dirs do
        local dirname = vim.fs.dirname(dirs[i])
        local_cmd = vim.fs.joinpath(dirname, "node_modules/.bin", cmd)

        if vim.fn.executable(local_cmd) == 1 then
          root_dir = dirname
          break
        end
      end

      on_dir(root_dir)
    end,
  })

  -- ---@type table<number, boolean>
  -- local oxlint_enabled = {}
  -- ---@type table<number, boolean>
  -- local oxlint_pending = {}
  --
  -- local group = vim.api.nvim_create_augroup("oxlint_diagnostics", { clear = true })
  --
  -- vim.api.nvim_create_autocmd("LspRequest", {
  --   group = group,
  --   callback = function(ev)
  --     local request = ev.data.request
  --     if request.method ~= "textDocument/diagnostic" then
  --       return
  --     end
  --     local client = vim.lsp.get_client_by_id(ev.data.client_id)
  --     if not client or client.name ~= "oxlint" then
  --       return
  --     end
  --     if request.type == "pending" then
  --       oxlint_pending[ev.buf] = true
  --       oxlint_enabled[ev.buf] = nil
  --       return
  --     end
  --     if request.type == "complete" then
  --       oxlint_pending[ev.buf] = nil
  --     end
  --   end,
  -- })
  --
  -- vim.api.nvim_create_autocmd("LspAttach", {
  --   group = group,
  --   callback = function(args)
  --     local client = vim.lsp.get_client_by_id(args.data.client_id)
  --     if client and client.name == "oxlint" and not client._patched then
  --       oxlint_enabled[args.buf] = true
  --       client._patched = true
  --       local orig = client.supports_method
  --       function client:supports_method(method, bufnr)
  --         if method == vim.lsp.protocol.Methods.textDocument_diagnostic then
  --           bufnr = bufnr or 0
  --           bufnr = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
  --           return oxlint_enabled[bufnr] or false
  --         end
  --         return orig(self, method, bufnr)
  --       end
  --     end
  --   end,
  -- })
  --
  -- vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  --   group = group,
  --   callback = function(ev)
  --     local client = vim.lsp.get_clients({ name = "oxlint", bufnr = ev.buf })[1]
  --     if not client then
  --       return
  --     end
  --     if oxlint_pending[ev.buf] then
  --       return
  --     end
  --     oxlint_enabled[ev.buf] = true
  --     if client:supports_method("textDocument/diagnostic") then
  --       if vim.api.nvim_buf_is_loaded(ev.buf) then
  --         pcall(vim.lsp.diagnostic._refresh, ev.buf, client.id, true)
  --       end
  --     end
  --   end,
  -- })

  vim.lsp.enable("oxlint") -- npm i -g oxlint
  vim.lsp.enable("graphql") -- npm install -g graphql-language-service-cli
  -- vim.lsp.enable("denols")

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
                  client:exec_cmd(r.command)
                end
              end
            end
          end,
        })
      end

      if client ~= nil and client.name == "oxlint" then
        vim.keymap.set("n", "<leader>lo", "<cmd>LspOxlintFixAll<cr>", { desc = "oxlint fix all" })
      end

      if client ~= nil and client.name == "tsc" then
        vim.keymap.set(
          "n",
          "<leader>lu",
          require("dlvhdr.plugins.lsp.handlers").action["source.removeUnusedImports"],
          { desc = "Remove [u]nused" }
        )
        vim.keymap.set(
          "n",
          "<leader>lm",
          require("dlvhdr.plugins.lsp.handlers").action["source.addMissingImports"],
          { desc = "[O]rganize imports" }
        )
        vim.keymap.set(
          "n",
          "<leader>lo",
          require("dlvhdr.plugins.lsp.handlers").action["source.organizeImports"],
          { desc = "[O]rganize imports" }
        )
      end
    end,
  })
end

return M
