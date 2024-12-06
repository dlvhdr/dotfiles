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
  -- vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { silent = true, buffer = bufnr, desc = "Code Action" })
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

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

local format_augroup = vim.api.nvim_create_augroup("LSPFormatting", {})

M.on_attach = function(client, bufnr)
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

  if client.supports_method("textDocument/inlayHint") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "", {
      callback = function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
      desc = "Inlay hints",
    })
    local wk = require("which-key")
    wk.add({
      { "<leader>lh", icon = "󰨚 " },
    })
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

  M.lsp_keymaps(bufnr)
end

M.capabilities = function()
  local global_capabilities = {
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    },
  }
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }

  return vim.tbl_deep_extend(
    "force",
    has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    global_capabilities or {},
    capabilities
  )
end

---@param opts? lsp.Client.filter
function M.get_clients(opts)
  local ret = {} ---@type vim.lsp.Client[]
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ---@param client vim.lsp.Client
      ret = vim.tbl_filter(function(client)
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

---@param from string
---@param to string
---@param rename? fun()
function M.on_rename(from, to, rename)
  local changes = { files = { {
    oldUri = vim.uri_from_fname(from),
    newUri = vim.uri_from_fname(to),
  } } }

  local clients = M.get_clients()
  for _, client in ipairs(clients) do
    if client.supports_method("workspace/willRenameFiles") then
      local resp = client.request_sync("workspace/willRenameFiles", changes, 1000, 0)
      if resp and resp.result ~= nil then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
      end
    end
  end

  if rename then
    rename()
  end

  for _, client in ipairs(clients) do
    if client.supports_method("workspace/didRenameFiles") then
      client.notify("workspace/didRenameFiles", changes)
    end
  end
end

M.action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      })
    end
  end,
})

return M
