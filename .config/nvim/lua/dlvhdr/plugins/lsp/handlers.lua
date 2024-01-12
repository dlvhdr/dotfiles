local M = {}

local signs = {
  { name = "DiagnosticSignError", text = "󰅙" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
  { name = "DiagnosticSignHint", text = "" },
}

M.setup = function()
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
end

M.lsp_keymaps = function(bufnr)
  -- builtins
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = bufnr, desc = "Go To Declaration" })
  vim.keymap.set("n", "gR", M.rename, { expr = true, desc = "Rename Symbol" })
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { silent = true, buffer = bufnr, desc = "Code Action" })
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, { silent = true, buffer = bufnr, desc = "Hover Symbol" })
  vim.keymap.set("n", "ge", vim.diagnostic.open_float, { silent = true, buffer = bufnr, desc = "Show Diagnostic" })
  vim.keymap.set("n", "gH", vim.lsp.buf.signature_help, { silent = true, buffer = bufnr, desc = "Signature Help" })
  vim.keymap.set("n", "[d", M.diagnostic_goto(true), { silent = true, buffer = bufnr, desc = "Next Diagnostic" })
  vim.keymap.set("n", "]d", M.diagnostic_goto(false), { silent = true, buffer = bufnr, desc = "Previous Diagnostic" })
  vim.keymap.set(
    "n",
    "[e",
    M.diagnostic_goto(true, vim.diagnostic.severity.ERROR),
    { silent = true, buffer = bufnr, desc = "Next Error" }
  )
  vim.keymap.set(
    "n",
    "]e",
    M.diagnostic_goto(false, vim.diagnostic.severity.ERROR),
    { silent = true, buffer = bufnr, desc = "Previous Error" }
  )
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

local format_augroup = vim.api.nvim_create_augroup("LSPFormatting", {})
local auto_format_enabled = true

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.name == "lua_ls" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_clear_autocmds({
      group = format_augroup,
      buffer = bufnr,
    })
  end

  -- if client.server_capabilities.codeLensProvider then
  --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
  --     pattern = "<buffer>",
  --     callback = function()
  --       -- vim.lsp.codelens.refresh()
  --     end,
  --     group = vim.api.nvim_create_augroup("LSPCodeLens", { clear = true }),
  --   })
  --   vim.keymap.set(
  --     "n",
  --     "gl",
  --     "<cmd>lua vim.lsp.codelens.run()<CR>",
  --     { silent = true, buffer = bufnr, desc = "Codelens" }
  --   )
  -- end

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

  M.lsp_keymaps(bufnr)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.preselectSupport = true
M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
M.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
M.capabilities.textDocument.completion.completionItem.resolveSupport =
  { properties = { "documentation", "detail", "additionalTextEdits" } }
M.capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

return M
