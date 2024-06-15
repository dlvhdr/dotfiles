local M = {
  "RRethy/vim-illuminate",
  event = "CursorHold",
  enabled = false,
}

M.config = function()
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end

  illuminate.configure({
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" },
    },
    filetypes_denylist = {
      "help",
      "dashboard",
      "NvimTree",
      "packer",
      "Trouble",
      "Outline",
      "DressingSelect",
      "TelescopePrompt",
      "noice",
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    modes_denylist = { "v", "x", "V" },
    -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
  })
end

return M
