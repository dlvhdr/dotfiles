local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
    { name = "DiagnosticSignHint", text = "" },
  }
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

local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }

  -- builtins
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<leader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- buf_set_keymap("n", "ge", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  -- buf_set_keymap("n", "[d", '<cmd>lua vim.lsp.diagnostic.goto_prev({border = "rounder"})<CR>', opts)
  -- buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

  -- telescope
  buf_set_keymap("n", "gr", '<cmd>lua require("dlvhdr.telescope").lsp_references()<CR>', opts)
  buf_set_keymap("n", "gd", '<cmd>lua require("dlvhdr.telescope").lsp_definitions()<CR>', opts)

  -- lspsaga
  buf_set_keymap("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", opts)
  buf_set_keymap("x", "<leader>ca", ":<c-u>Lspsaga range_code_action<cr>", opts)
  buf_set_keymap("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opts)
  buf_set_keymap("n", "ge", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
  buf_set_keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
  buf_set_keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
  buf_set_keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", opts)
  buf_set_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", opts)
end

M.on_attach = function(client, bufnr)
  -- print(vim.inspect(client))
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end

  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 10000)")
  end

  lsp_keymaps(bufnr)
  lsp_highlight_document(client)

  require("dlvhdr.lsp.lsp_signature").setup(bufnr)

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
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true

M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

return M
