local components = require("dlvhdr.lualine.components")

local colors_ok, colors = pcall(require, "tokyonight.colors")
if not colors_ok then
  return
end
colors = colors.setup({})

local tree_view_ok, tree_view = pcall(require, "nvim-tree.view")
if not tree_view_ok then
  return
end

local nvim_tree_shift = {
  function()
    local name = "פּ Nvim Tree"
    local empty_space = string.rep(" ", ((vim.api.nvim_win_get_width(tree_view.get_winnr()) - #name) / 2))
    return empty_space .. name .. empty_space
  end,
  cond = tree_view.is_visible,
  color = { fg = colors.comment, bg = colors.bg_dark, gui = "italic" },
}

require("lualine").setup({
  options = {
    theme = "tokyonight",
    globalstatus = vim.opt.laststatus:get() == 3,
    component_separators = "",
    section_separators = "",
    disabled_filetypes = { "dashboard", "Outline" },
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
      components.diff,
    },
    lualine_c = {
      components.diagnostics,
    },
    lualine_x = {
      components.treesitter,
      components.lsp,
      -- components.filetype,
    },
    lualine_y = {},
    lualine_z = {
      components.location,
      components.scrollbar,
      nvim_tree_shift,
    },
  },
})
