return {
  "pmizio/typescript-tools.nvim",
  event = "BufReadPost",
  enabled = false,
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local ok, tst = pcall(require, "typescript-tools")
    local lsp = require("dlvhdr.plugins.lsp.handlers")

    if not ok then
      return
    end

    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      }),
    }
    tst.setup({
      handlers = handlers,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        lsp.lsp_keymaps(bufnr)
      end,
      settings = {
        separate_diagnostic_server = true,
        composite_mode = "separate_diagnostic",
        publish_diagnostic_on = "insert_leave",
        -- tsserver_logs = "verbose",
        tsserver_file_preferences = {
          importModuleSpecifierPreference = "non-relative",
        },
      },
    })
  end,
}
