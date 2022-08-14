local components = require("dlvhdr.lualine.components")

require("lualine").setup({
  options = {
    theme = "tokyonight",
    component_separators = "",
    section_separators = "",
    disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
    icons_enabled = true,
  },
  tabline = {},
  extensions = {},
  sections = {
    lualine_a = {
      components.mode,
    },
    lualine_b = {
      components.branch,
    },
    lualine_c = {
      components.filename,
    },
    lualine_x = {
      components.diagnostics,
      components.diff,
      components.treesitter,
      components.lsp,
      -- components.filetype,
    },
    lualine_y = {},
    lualine_z = {
      components.location,
      components.scrollbar,
    },
  },
})
