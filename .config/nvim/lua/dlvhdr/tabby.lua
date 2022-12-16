local ok, tabby = pcall(require, "tabby")
if not ok then
  return
end

local theme = require("dlvhdr.theme")
local colors = theme.colors

local hl_tabline_fill = { fg = colors.fg_dark, bg = colors.bg_dark }
local hl_tabline = { fg = colors.fg_dark, bg = colors.bg_dark }
local hl_tabline_sel = { fg = colors.fg, bg = colors.bg_dark }

local function tab_label(tabid, active)
  local icon = active and "" or ""
  local number = vim.api.nvim_tabpage_get_number(tabid)
  return string.format("%s %d", icon, number)
end

local tab_only = {
  hl = "lualine_c_normal",
  layout = "tab_only",
  active_tab = {
    label = function(tabid)
      return {
        tab_label(tabid, true),
        hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg, style = "bold" },
      }
    end,
    right_sep = { " ", hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
  },
  inactive_tab = {
    label = function(tabid)
      return {
        tab_label(tabid, false),
        hl = { fg = hl_tabline.fg, bg = hl_tabline_fill.bg },
      }
    end,
    right_sep = { " ", hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
  },
}

tabby.setup({ tabline = tab_only })
