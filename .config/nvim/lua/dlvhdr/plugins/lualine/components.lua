local conditions = require("dlvhdr.plugins.lualine.conditions")
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
    icon = "",
    color = { fg = colors.fg_dark, bg = "NONE" },
    cond = conditions.hide_in_width,
  },
  diff = {
    "diff",
    source = diff_source,
    symbols = { added = "+", modified = "~", removed = "-" },
    color = { fg = colors.fg_dark, bg = "NONE" },
    colored = false,
    cond = nil,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
    color = { fg = colors.fg_dark, bg = "NONE" },
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
    color = { fg = colors.fg_dark, bg = "NONE" },
    cond = conditions.hide_in_width,
  },
  lsp = {
    function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
      if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name == "copilot" then
          table.insert(buf_client_names, "")
        elseif client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end

      -- add formatter
      local formatters = require("dlvhdr.plugins.lsp.servers.null-ls.formatters")
      local supported_formatters = formatters.list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters = require("dlvhdr.plugins.lsp.servers.null-ls.linters")
      local supported_linters = linters.list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_linters)

      local unique_client_names = vim.fn.sort(buf_client_names)
      unique_client_names = vim.fn.uniq(unique_client_names)
      return table.concat(unique_client_names, "  ")
    end,
    color = { fg = colors.fg_dark, bg = "NONE" },
  },
  location = {
    "location",
    cond = conditions.hide_in_width,
    color = { fg = colors.fg_dark, bg = "NONE" },
  },
  progress = {
    "progress",
    cond = conditions.hide_in_width,
    color = { fg = colors.fg_dark, bg = "NONE" },
  },
  spaces = {
    function()
      local label = "Spaces: "
      if not vim.api.nvim_buf_get_option(0, "expandtab") then
        label = "Tab size: "
      end
      return label .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
    end,
    cond = conditions.hide_in_width,
    color = { fg = colors.fg_dark, bg = "NONE" },
  },
  encoding = {
    "o:encoding",
    fmt = string.upper,
    color = { fg = colors.fg_dark, bg = "NONE" },
    cond = conditions.hide_in_width,
  },
  filetype = {
    "filetype",
    cond = conditions.hide_in_width,
    color = { fg = colors.fg_dark, bg = "NONE" },
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

      vim.api.nvim_set_hl(0, "LuaLineFileIcon", { fg = devicon_color or colors.fg_dark, bg = "NONE" })
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
      local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = { left = 0, right = 0 },
    color = { fg = colors.fg_dark, bg = "NONE" },
    cond = nil,
  },
}
