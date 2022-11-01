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
  local opts = { silent = true, buffer = bufnr }

  -- builtins
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.keymap.set("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.keymap.set("n", "<leader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- telescope
  vim.keymap.set("n", "gr", '<cmd>lua require("dlvhdr.telescope").lsp_references()<CR>', opts)
  vim.keymap.set("n", "gR", "<cmd>Lspsaga lsp_finder<CR>", opts)
  vim.keymap.set("n", "gd", '<cmd>lua require("dlvhdr.telescope").lsp_definitions()<CR>', opts)
  vim.keymap.set("n", "gD", "<cmd>Lspsaga preview_definition<CR>", opts)

  -- lspsaga
  vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
  vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", opts)
  vim.keymap.set("x", "<leader>ca", ":<c-u>Lspsaga range_code_action<cr>", opts)
  vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opts)
  vim.keymap.set("n", "ge", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
  vim.keymap.set("n", "gs", "<Cmd>Lspsaga signature_help<CR>", { silent = true })
  vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
  vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
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
    vim.keymap.set("n", "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<CR>", { silent = true, buffer = bufnr })
  end

  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  -- require("dlvhdr.lsp.lsp_signature").setup(bufnr)

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

  lsp_status.on_attach(client, bufnr)
  lsp_keymaps(bufnr)
end

lsp_status.config({
  status_symbol = " ",
  current_function = true,
  diagnostics = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

return M
