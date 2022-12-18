local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

indent_blankline.setup({
  enabled = true,
  buftype_exclude = { "terminal", "nofile" },
  filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "alpha",
    "packer",
    "man",
    "sagasignature",
    "sagahover",
    "lspsagafinder",
    "LspSagaCodeAction",
    "TelescopePrompt",
    "NvimTree",
    "Trouble",
    "DiffviewFiles",
    "DiffviewFileHistory",
    "Outline",
    "lspinfo",
    "fugitive",
    "norg",
  },
  char = "▏",
  show_trailing_blankline_indent = false,
  use_treesitter = true,
  show_current_context = true,
})
