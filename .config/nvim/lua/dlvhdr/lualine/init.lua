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
  extensions = { "nvim-tree", "toggleterm" },
  sections = {
    lualine_a = {
      components.mode,
    },
    lualine_b = {
      -- components.session,
      components.branch,
    },
    lualine_c = {
      components.filename,
      components.diff,
    },
    lualine_x = {
      -- components.lsp_progress,
      components.diagnostics,
      components.treesitter,
      components.lsp,
      components.filetype,
    },
    lualine_y = {},
    lualine_z = {
      components.scrollbar,
    },
  },
})
