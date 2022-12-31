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

  local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
  }
  local pop_opts = { border = border, max_width = 80 }
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, pop_opts)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, pop_opts)
end

local function lsp_keymaps(bufnr)
  -- builtins
  vim.keymap.set(
    "n",
    "gD",
    "<cmd>lua vim.lsp.buf.declaration()<CR>",
    { silent = true, buffer = bufnr, desc = "Declarations" }
  )
  -- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true, buffer = bufnr, desc = "" })
  -- vim.keymap.set(
  --   "n",
  --   "<leader>gD",
  --   "<cmd>lua vim.lsp.buf.type_definition()<CR>",
  --   { silent = true, buffer = bufnr, desc = "Type Definition" }
  -- )
  -- telescope
  vim.keymap.set(
    "n",
    "gr",
    '<cmd>lua require("dlvhdr.plugins.telescope").lsp_references()<CR>',
    { silent = true, buffer = bufnr, desc = "References" }
  )
  vim.keymap.set(
    "n",
    "gd",
    '<cmd>lua require("dlvhdr.plugins.telescope").lsp_definitions()<CR>',
    { silent = true, buffer = bufnr, desc = "Definitions" }
  )

  -- lspsaga
  vim.keymap.set(
    "n",
    "<leader>gn",
    "<cmd>Lspsaga rename<cr>",
    { silent = true, buffer = bufnr, desc = "Rename Symbol" }
  )
  vim.keymap.set(
    "n",
    "<leader>ga",
    "<cmd>Lspsaga code_action<cr>",
    { silent = true, buffer = bufnr, desc = "Code Action" }
  )
  vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<cr>", { silent = true, buffer = bufnr, desc = "Show Hover Info" })
  vim.keymap.set(
    "n",
    "ge",
    "<cmd>Lspsaga show_line_diagnostics<cr>",
    { silent = true, buffer = bufnr, desc = "Show Line Diagnostics" }
  )
end

M.on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider and client.name ~= "sumneko_lua" then
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      buffer = bufnr,
      callback = function()
        if vim.lsp.buf.server_ready() then
          vim.lsp.buf.format({ bufnr = bufnr }, 3000)
        end
      end,
      group = vim.api.nvim_create_augroup("LSPFormat_" .. bufnr, { clear = true }),
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
    vim.keymap.set("n", "<leader>gl", "<cmd>lua vim.lsp.codelens.run()<CR>", { silent = true, buffer = bufnr })
  end

  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  local config = {
    virtual_text = false,
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

  lsp_status.on_attach(client, bufnr)
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
