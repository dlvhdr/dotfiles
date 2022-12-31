local M = {
  "folke/tokyonight.nvim",

  lazy = false,
}

M.colors = function()
  local colors_ok, colors = pcall(require, "tokyonight.colors")
  if not colors_ok then
    return
  end
  return colors.setup({})
end

M.util = function()
  local util_ok, util = pcall(require, "tokyonight.util")
  if not util_ok then
    return
  end

  return util
end

M.config = function()
  local status_ok, tokyonight = pcall(require, "tokyonight")
  if not status_ok then
    return
  end

  tokyonight.setup({
    style = "storm",
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "dark",
      floats = "normal",
    },
    sidebars = {
      "terminal",
      "packer",
      "help",
      "NvimTree",
      "Trouble",
      "LspInfo",
    },
    dim_inactive = false,
    lualine_bold = false,
    on_highlights = function(hl, c)
      hl.WhichKeyGroup = {
        fg = c.green,
        bold = true,
      }
      hl.BufferVisibleMod = { fg = c.yellow, bg = c.bg }
    end,
  })

  tokyonight.load()

  local colors = M.colors()
  local util = M.util()

  if not colors or not util then
    return
  end

  vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = util.darken(colors.border_highlight, 0.3), bg = "NONE" })

  local darker_bg = util.darken(colors.bg_popup, 2.5)
  vim.api.nvim_set_hl(0, "CmpDocumentation", { bg = darker_bg })
  vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { bg = darker_bg })
  vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = colors.warning, bold = true })
  vim.api.nvim_set_hl(0, "TreesitterContext", { bg = colors.bg_highlight })
  vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = colors.blue })

  vim.api.nvim_set_hl(0, "GHThreadSep", { bg = colors.bg_float })
  vim.api.nvim_set_hl(0, "markdownH1", { bg = colors.bg_float })

  vim.api.nvim_set_hl(0, "CmpBorder", { fg = colors.fg_gutter, bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = colors.fg_gutter, bg = "NONE" })

  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.fg_gutter, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colors.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = colors.teal, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = colors.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = colors.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopeResultsDiffAdd", { fg = colors.green, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopeResultsDiffChange", { fg = colors.yellow, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopeResultsDiffDelete", { fg = colors.red, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = colors.green, bold = true, bg = "NONE" })

  vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = colors.yellow, bold = true })

  vim.api.nvim_set_hl(0, "DevIconFish", { fg = colors.green })

  vim.api.nvim_set_hl(0, "Folded", { bg = colors.bg_popup, italic = true })
  vim.api.nvim_set_hl(0, "FoldColumn", { fg = colors.blue })
end

return M
