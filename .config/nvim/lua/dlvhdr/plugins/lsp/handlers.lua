local lsp_status_ok, lsp_status = pcall(require, "lsp-status")
if not lsp_status_ok then
  return
end

local M = {}

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
  { name = "DiagnosticSignHint", text = "" },
}

M.setup = function()
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
end

local function lsp_keymaps(bufnr)
  local opts = { silent = true, buffer = bufnr }

  -- builtins
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

  -- telescope
  vim.keymap.set("n", "gr", '<cmd>lua require("dlvhdr.plugins.telescope").lsp_references()<CR>', opts)
  vim.keymap.set("n", "gd", '<cmd>lua require("dlvhdr.plugins.telescope").lsp_definitions()<CR>', opts)

  vim.keymap.set("n", "<leader>gr", M.rename, { expr = true })
  vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "gH", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "[d", M.diagnostic_goto(true), opts)
  vim.keymap.set("n", "]d", M.diagnostic_goto(false), opts)
end

function M.rename()
  if pcall(require, "inc_rename") then
    return ":IncRename " .. vim.fn.expand("<cword>")
  else
    vim.lsp.buf.rename()
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      group = vim.api.nvim_create_augroup("LSPFormat_" .. bufnr, {}),
      buffer = bufnr,
      callback = function()
        if vim.lsp.buf.server_ready() then
          vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
        end
      end,
    })
  end

  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
      pattern = "<buffer>",
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      group = vim.api.nvim_create_augroup("LSPCodeLens", { clear = true }),
    })
    vim.keymap.set("n", "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<CR>", { silent = true, buffer = bufnr })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }
  vim.diagnostic.config(config)

  lsp_status.on_attach(client)
  lsp_keymaps(bufnr)
end

lsp_status.config({
  status_symbol = " ",
  current_function = true,
  diagnostics = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

return M
