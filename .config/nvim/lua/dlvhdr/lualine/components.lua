local conditions = require("dlvhdr.lualine.conditions")
local colors = require("dlvhdr.lualine.colors")

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
  session = {
    function()
      local persistence = require("persistence")

      local session_name = persistence.get_current()
      session_name = vim.fn.getcwd():gsub("%%", "/")

      if session_name == "" then
        session_name = "-"
      end

      session_name = session_name:gsub(vim.fn.expand("~/code/wix"), "@wix")
      session_name = session_name:gsub(vim.fn.expand("~/"), "")
      return string.format(" %s", session_name)
    end,
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
    symbols = { added = "  ", modified = "柳", removed = " " },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    color = {},
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
    color = { fg = colors.green },
    cond = conditions.hide_in_width,
  },
  lsp = {
    function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end

      -- add formatter
      local formatters = require("lvim.lsp.null-ls.formatters")
      local supported_formatters = formatters.list_supported_names(buf_ft)
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters = require("lvim.lsp.null-ls.linters")
      local supported_linters = linters.list_supported_names(buf_ft)
      vim.list_extend(buf_client_names, supported_linters)

      return table.concat(buf_client_names, ", ")
    end,
    icon = " ",
    color = { gui = "bold" },
  },
  location = { "location", cond = conditions.hide_in_width, color = {} },
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
    "filename",
    path = 0,
    file_status = true,
    symbols = { modified = "  ", readonly = "  " },
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
    color = { fg = colors.yellow, bg = colors.bg },
    cond = nil,
  },
  -- lsp_progress = {
  --   "lsp_progress",
  --   display_components = { "lsp_client_name", "spinner", { "title", "percentage" } },
  --   colors = {
  --     percentage = colors.violet,
  --     title = colors.violet,
  --     message = colors.violet,
  --     spinner = colors.violet,
  --     lsp_client_name = colors.blue,
  --     use = true,
  --   },
  --   icon = "理",
  --   fmt = function(data)
  --     return string.sub(data, 1, vim.o.columns / 2)
  --   end,
  --   separators = {
  --     component = " ",
  --     progress = " | ",
  --     message = { pre = "(", post = ")" },
  --     percentage = { pre = "", post = "%% " },
  --     title = { pre = "", post = "" },
  --     lsp_client_name = { pre = "[", post = "]" },
  --     spinner = { pre = "", post = "" },
  --     message = { commenced = "In Progress", completed = "Completed" },
  --   },
  --   timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
  --   spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
  -- },
}
