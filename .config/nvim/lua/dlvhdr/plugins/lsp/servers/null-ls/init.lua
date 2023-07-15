local M = {}

local null_ls = require("null-ls")
local lspconfigUtils = require("lspconfig.util")
local utils = require("dlvhdr.plugins.lsp.servers.null-ls.utils")
local formatters = require("dlvhdr.plugins.lsp.servers.null-ls.formatters")
local linters = require("dlvhdr.plugins.lsp.servers.null-ls.linters")

M.setup = function(opts)
  null_ls.setup({
    on_attach = opts.on_attach,
    root_dir = lspconfigUtils.root_pattern(".git"),
    timeout_ms = 7000,
    sources = {
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.goimports_reviser,
      null_ls.builtins.formatting.golines.with({ extra_args = { "-m", "80" } }),
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.shellcheck.with({ filetypes = { "sh" } }),
      null_ls.builtins.formatting.stylua.with({
        condition = function()
          return lspconfigUtils.root_pattern("stylua.toml")
        end,
      }),
      null_ls.builtins.formatting.eslint_d.with({
        condition = function()
          return utils.has_eslint_prettier_plugin()
        end,
      }),
      null_ls.builtins.formatting.prettierd.with({
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "css",
          "scss",
          "less",
          "html",
          "json",
          "yaml",
          "yml",
          "graphql",
          -- "markdown",
        },
        condition = function()
          return not utils.has_eslint_prettier_plugin()
        end,
      }),
      null_ls.builtins.diagnostics.eslint_d.with({
        condition = function()
          local has = utils.has_eslint_config()
          return has
        end,
      }),
    },
  })

  vim.api.nvim_create_user_command("NullLsRestart", function()
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}
    local supported_formatters = formatters.list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_formatters)
    local supported_linters = linters.list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_linters)
    for _, provider in ipairs(buf_client_names) do
      if provider == "eslint_d" then
        vim.notify("Restarting eslint_d")
        vim.cmd("!eslint_d restart")
      end

      if provider == "prettierd" then
        vim.notify("Restarting prettierd")
        vim.cmd("!prettierd restart")
      end
    end
    require("null-ls.client")._reset()
    vim.cmd.edit()
  end, {})
end

return M
