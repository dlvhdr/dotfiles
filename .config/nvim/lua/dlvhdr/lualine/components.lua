local conditions = require("dlvhdr.lualine.conditions")
local colors = require("tokyonight.colors").setup({})

local function color(highlight_group, content)
  return "%#" .. highlight_group .. "#" .. content .. "%*"
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

return {
  mode = {
    function()
      return " "
    end,
    padding = { left = 0, right = 0 },
    color = {},
    cond = nil,
  },
  branch = {
    "b:gitsigns_head",
    icon = " ",
    color = { gui = "bold" },
    cond = conditions.hide_in_width,
  },
  diff = {
    "diff",
    source = diff_source,
    symbols = { added = "+", modified = "~", removed = "-" },
    colored = false,
    cond = nil,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    color = {},
    cond = nil,
  },
  treesitter = {
    function()
      local b = vim.api.nvim_get_current_buf()
      if next(vim.treesitter.highlighter.active[b]) then
        return "  "
      end
      return ""
    end,
    color = { fg = colors.fg_dark },
    cond = conditions.hide_in_width,
  },
  lsp = function()
    return require("lsp-status").status()
  end,
  location = {
    "location",
    cond = conditions.hide_in_width,
    color = { bg = colors.bg_statusline, fg = colors.fg_dark },
  },
  progress = { "progress", cond = conditions.hide_in_width, color = {} },
  spaces = {
    function()
      local label = "Spaces: "
      if not vim.api.nvim_buf_get_option(0, "expandtab") then
        label = "Tab size: "
      end
      return label .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
    end,
    cond = conditions.hide_in_width,
    color = {},
  },
  encoding = {
    "o:encoding",
    fmt = string.upper,
    color = {},
    cond = conditions.hide_in_width,
  },
  filetype = {
    "filetype",
    cond = conditions.hide_in_width,
    color = {},
  },
  filename = {
    function()
      local is_active = winnr == vim.fn.winnr()
      local bufnum = vim.fn.winbufnr(winnr)

      local segments = {}

      -- File name
      local file_name = vim.fn.fnamemodify(vim.fn.bufname(bufnum), ":t")
      local extension = vim.fn.expand("#" .. bufnum .. ":e")
      local icon, devicon_color = require("nvim-web-devicons").get_icon_color(file_name, extension)

      if not icon and #file_name == 0 then
        -- Is in a folder
        icon = ""
        devicon_color = colors.fg_dark
      end

      -- File modified
      local bufname = vim.fn.bufname(bufnum)
      if bufname ~= "" and vim.fn.getbufvar(bufnum, "&modified") == 1 then
        table.insert(segments, color("DiagnosticWarn", ""))
      end

      -- Read only
      if vim.fn.getbufvar(bufnum, "&readonly") == 1 then
        table.insert(segments, color("StatuslineBoolean", ""))
      end

      -- Icon

      vim.api.nvim_set_hl(0, "LuaLineFileIcon", { fg = devicon_color or colors.fg, bg = colors.bg_statusline })
      local icon_statusline = color("LuaLineFileIcon", icon or "")
      table.insert(segments, icon_statusline)

      -- File path
      local file_path = '%{expand("%:t")}'
      table.insert(segments, file_path)

      return table.concat(segments, " ")
    end,
  },
  scrollbar = {
    function()
      local current_line = vim.fn.line(".")
      local total_lines = vim.fn.line("$")
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = { left = 0, right = 0 },
    color = { fg = colors.fg_dark, bg = colors.bg_statusline },
    cond = nil,
  },
}
