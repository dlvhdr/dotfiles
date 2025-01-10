local M = {
  "folke/tokyonight.nvim",
  priority = 1000,
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
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "transparent",
      floats = "transparent",
    },
    dim_inactive = false,
    lualine_bold = false,
    on_highlights = function(hl, c)
      local util = require("tokyonight.util")
      local darker_bg = util.darken(c.bg_popup, 2.5)
      local darker_orange = util.darken(c.orange, 0.9)
      hl.LineNr.fg = c.comment
      hl.LineNrAbove.fg = c.comment
      hl.LineNrBelow.fg = c.comment
      hl.CursorLine = {
        bg = darker_bg,
      }
      hl.CursorLineNr = {
        fg = c.fg,
        bold = true,
      }
      hl.WhichKeyGroup = {
        fg = c.green,
        bold = true,
      }
      hl.BufferVisibleMod = { fg = c.yellow, bg = c.bg }
      hl.WinSeparator = {
        fg = util.darken(c.border_highlight, 0.3),
      }
      hl.NvimTreeSpecialFile = {
        fg = c.yellow,
        bold = true,
      }
      hl.TermCursor = { link = "Cursor" }
      hl.EndOfBuffer = { bg = "NONE" }

      hl.PmenuMatchSel = { fg = darker_orange }
      hl.PmenuMatch = { fg = darker_orange, bg = c.bg_highlight }

      hl.BlinkCmpMenu = { bg = "#010101" }
      hl.BlinkCmpMenuBorder = { fg = c.fg_gutter, bg = "#010101" }
      hl.BlinkCmpDoc = { bg = "#010101" }
      hl.BlinkCmpDocBorder = { fg = c.fg_gutter, bg = "#010101" }
      hl.BlinkCmpLabelMatch = { fg = darker_orange, bg = c.none }
      hl.BlinkCmpMenuSelection = { bg = c.bg_highlight }
      hl.BlinkCmpScrollBarThumb = { bg = darker_bg }
      -- hl.BlinkCmpLabel = { bg = "#010101" }

      hl.CmpDocumentation = { bg = darker_bg }
      hl.CmpDocumentationBorder = { bg = darker_bg }
      hl.TelescopeMatching = { fg = c.warning, bold = true }
      hl.TreesitterContext = { bg = c.bg_highlight }
      hl.NvimTreeFolderIcon = { fg = c.blue }
      hl.CmpBorder = { fg = c.fg_gutter, bg = "NONE" }
      hl.CmpDocBorder = { fg = c.fg_gutter, bg = "NONE" }
      hl.TelescopeBorder = { fg = c.fg_gutter, bg = "NONE" }
      hl.TelescopePromptBorder = { fg = c.fg_gutter, bg = "NONE" }
      hl.TelescopePromptTitle = { fg = c.blue, bg = "NONE" }
      hl.TelescopeResultsTitle = { fg = c.teal, bg = "NONE" }
      hl.TelescopePreviewTitle = { fg = c.fg, bg = "NONE" }
      hl.TelescopePromptPrefix = { fg = c.blue, bg = "NONE" }
      hl.TelescopeResultsDiffAdd = { fg = c.green, bg = "NONE" }
      hl.TelescopeResultsDiffChange = { fg = c.yellow, bg = "NONE" }
      hl.TelescopeResultsDiffDelete = { fg = c.red, bg = "NONE" }
      hl.TelescopeMatching = { fg = c.orange, bold = true, bg = "NONE" }
      hl.FoldColumn = { fg = "#141B23" }
      hl.DevIconFish = { fg = c.green }
      hl.GHThreadSep = { bg = c.bg_float }
      hl.DiagnosticUnnecessary = { fg = util.lighten(c.comment, 0.7), undercurl = true }
      hl.Directory = { fg = c.blue }
      hl.GitSignsAddNr = { fg = c.green }
      hl.GitSignsAddLn = { fg = c.green }
      hl.GitSignsAdd = { fg = c.green }
      hl.MatchParen = { bg = c.fg_gutter }
      hl.WinBar = { bg = "NONE" }
      hl.WinBarNC = { bg = "NONE" }
      hl.LspInlayHint = { bg = "NONE", fg = c.dark3 }
      hl.WhichKeyIcon = { bg = "NONE", fg = c.green }
      hl.WhichKeyIconRed = { bg = "NONE", fg = c.fg_dark }
      hl.WhichKeyIconBlue = { bg = "NONE", fg = c.fg_dark }
      hl.WhichKeyIconCyan = { bg = "NONE", fg = c.fg_dark }
      hl.WhichKeyIconGrey = { bg = "NONE", fg = c.fg_dark }
      hl.WhichKeyIconAzure = { bg = "NONE", fg = c.fg_dark }
      hl.WhichKeyIconGreen = { bg = "NONE", fg = c.fg_dark }
      hl.WhichKeyIconOrange = { bg = "NONE", fg = c.fg_dark }
      hl.WhichKeyIconPurple = { bg = "NONE", fg = c.fg_dark }
      hl.WhichKeyIconYellow = { bg = "NONE", fg = c.fg_dark }
      hl.WhichKeyGroup = { bg = "NONE", fg = c.fg }
      hl.WhichKeyDesc = { bg = "NONE", fg = c.fg }
      hl["@markup.list"] = { link = "@markup.strong" }
      hl["@markup.list.markdown"] = { link = "@markup.strong" }
      hl["@markup.heading.2"] = { fg = c.blue5, bold = true }
      hl["@markup.heading.2.markdown"] = { fg = c.blue5, bold = true }
      hl["@markup.heading.3"] = { link = "@markup.strong" }
      hl["@markup.heading.3.markdown"] = { link = "@markup.strong" }
      hl["@markup.heading.4"] = { link = "@markup.strong" }
      hl["@markup.heading.4.markdown"] = { link = "@markup.strong" }
      hl.DiffText = { bg = "#234E88" }
      hl.DiffChange = { bg = "#152339" }
      hl.DiffDelete = { bg = "#724022" }
      hl.DiffAdd = { bg = "#234E88" }
      hl.DiffviewDiffDeleteDim = { bg = "#2D1F1B" }
    end,
  })

  tokyonight.load()
end

return M
