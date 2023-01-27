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
      local util = require("tokyonight.util")
      local darker_bg = util.darken(c.bg_popup, 2.5)
      hl.WhichKeyGroup = {
        fg = c.green,
        bold = true,
      }
      hl.BufferVisibleMod = { fg = c.yellow, bg = c.bg }
      hl.Folded = {
        bg = util.lighten(c.bg_highlight, 0.98),
      }
      hl.WinSeparator = {
        fg = util.darken(c.border_highlight, 0.3),
      }
      hl.NvimTreeSpecialFile = {
        fg = c.yellow,
        bold = true,
      }
      hl.CmpDocumentation = { bg = darker_bg }
      hl.CmpDocumentationBorder = { bg = darker_bg }
      hl.TelescopeMatching = { fg = c.warning, bold = true }
      hl.TreesitterContext = { bg = c.bg_highlight }
      hl.NvimTreeFolderIcon = { fg = c.blue }
      hl.CmpBorder = { fg = c.fg_gutter, bg = "NONE" }
      hl.CmpDocBorder = { fg = c.fg_gutter, bg = "NONE" }
      hl.TelescopeBorder = { fg = c.fg_gutter, bg = "NONE" }
      hl.TelescopePromptTitle = { fg = c.blue, bg = "NONE" }
      hl.TelescopeResultsTitle = { fg = c.teal, bg = "NONE" }
      hl.TelescopePreviewTitle = { fg = c.fg, bg = "NONE" }
      hl.TelescopePromptPrefix = { fg = c.blue, bg = "NONE" }
      hl.TelescopeResultsDiffAdd = { fg = c.green, bg = "NONE" }
      hl.TelescopeResultsDiffChange = { fg = c.yellow, bg = "NONE" }
      hl.TelescopeResultsDiffDelete = { fg = c.red, bg = "NONE" }
      hl.TelescopeMatching = { fg = c.green, bold = true, bg = "NONE" }
      hl.FoldColumn = { fg = c.blue }
      hl.DevIconFish = { fg = c.green }
      hl.GHThreadSep = { bg = c.bg_float }
      hl.markdownH1 = { bg = c.bg_float }
    end,
  })

  tokyonight.load()
end

return M
