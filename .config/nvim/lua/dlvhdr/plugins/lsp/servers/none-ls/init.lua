local M = {}

local null_ls = require("null-ls")
local lspconfigUtils = require("lspconfig.util")
local utils = require("dlvhdr.plugins.lsp.servers.none-ls.utils")
local formatters = require("dlvhdr.plugins.lsp.servers.none-ls.formatters")
local linters = require("dlvhdr.plugins.lsp.servers.none-ls.linters")

M.setup = function(opts)
  null_ls.setup({
    on_attach = opts.on_attach,
    root_dir = lspconfigUtils.root_pattern(".git"),
    timeout_ms = 7000,
    sources = {
      require("none-ls.code_actions.eslint_d"),
      require("none-ls.diagnostics.eslint_d").with({
        condition = function()
          local has = utils.has_eslint_config()
          return has
        end,
      }),
      null_ls.builtins.diagnostics.codespell,
      null_ls.builtins.diagnostics.golangci_lint.with({
        extra_args = { "-E", "errcheck" },
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
