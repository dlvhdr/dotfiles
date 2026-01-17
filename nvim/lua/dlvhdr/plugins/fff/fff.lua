local M = {}

local staged_status = {
  staged_new = true,
  staged_modified = true,
  staged_deleted = true,
  renamed = true,
}

local status_map = {
  untracked = "untracked",
  modified = "modified",
  deleted = "deleted",
  renamed = "renamed",
  staged_new = "added",
  staged_modified = "modified",
  staged_deleted = "deleted",
  ignored = "ignored",
  -- clean = "",
  -- clear = "",
  unknown = "untracked",
}

---@class FFFState
---@field current_file_cache? string
M.state = {}

---@type snacks.picker.finder
---@diagnostic disable-next-line: unused-local
local function finder(opts, ctx)
  local file_picker = require("fff.file_picker")

  if not M.state.current_file_cache then
    local current_buf = vim.api.nvim_get_current_buf()
    if current_buf and vim.api.nvim_buf_is_valid(current_buf) then
      local current_file = vim.api.nvim_buf_get_name(current_buf)
      if current_file ~= "" and vim.fn.filereadable(current_file) == 1 then
        M.state.current_file_cache = vim.fn.fnamemodify(current_file, ":.")
      else
        M.state.current_file_cache = nil
      end
    end
  end

  local fff_result = file_picker.search_files(ctx.filter.search, M.state.current_file_cache, 100, 4, nil)

  ---@type snacks.picker.finder.Item[]
  local items = {}
  for _, fff_item in ipairs(fff_result) do
    ---@type snacks.picker.finder.Item
    local item = {
      text = fff_item.name,
      file = fff_item.path,
      score = fff_item.total_frecency_score,
      status = status_map[fff_item.git_status] and {
        status = status_map[fff_item.git_status],
        staged = staged_status[fff_item.git_status] or false,
        unmerged = fff_item.git_status == "unmerged",
      },
    }
    items[#items + 1] = item
  end

  return items
end

local function on_close()
  M.state.current_file_cache = nil
end

local function format_file_git_status(item, picker)
  local ret = {} ---@type snacks.picker.Highlight[]
  local status = item.status

  local hl = "SnacksPickerGitStatus"
  if status.unmerged then
    hl = "SnacksPickerGitStatusUnmerged"
  elseif status.staged then
    hl = "SnacksPickerGitStatusStaged"
  else
    hl = "SnacksPickerGitStatus" .. status.status:sub(1, 1):upper() .. status.status:sub(2)
  end

  local icon = picker.opts.icons.git[status.status]
  if status.staged then
    icon = picker.opts.icons.git.staged
  end

  local text_icon = status.status:sub(1, 1):upper()
  text_icon = status.status == "untracked" and "?" or status.status == "ignored" and "!" or text_icon

  ret[#ret + 1] = { icon, hl }
  ret[#ret + 1] = { " ", virtual = true }

  ret[#ret + 1] = {
    col = 0,
    virt_text = { { text_icon, hl }, { " " } },
    virt_text_pos = "right_align",
    hl_mode = "combine",
  }
  return ret
end

local function format(item, picker)
  ---@type snacks.picker.Highlight[]
  local ret = {}

  if item.label then
    ret[#ret + 1] = { item.label, "SnacksPickerLabel" }
    ret[#ret + 1] = { " ", virtual = true }
  end

  if item.status then
    vim.list_extend(ret, format_file_git_status(item, picker))
  else
    ret[#ret + 1] = { "  ", virtual = true }
  end

  vim.list_extend(ret, require("snacks.picker.format").filename(item, picker))

  if item.line then
    Snacks.picker.highlight.format(item, item.line, ret)
    table.insert(ret, { " " })
  end
  return ret
end

function M.fff()
  local file_picker = require("fff.file_picker")
  if not file_picker.is_initialized() then
    local setup_success = file_picker.setup()
    if not setup_success then
      vim.notify("Failed to initialize file picker", vim.log.levels.ERROR)
    end
  end
  Snacks.picker({
    title = "FFFiles",
    finder = finder,
    preview = "none",
    layout = { preset = "select" },
    formatters = {
      file = {
        filename_first = true, -- display filename before the file path
        truncate = 80, -- truncate the file path to (roughly) this length
        filename_only = false, -- only show the filename
        icon_width = 2, -- width of the icon (in characters)
        git_status_hl = true, -- use the git status highlight group for the filename
      },
    },
    on_close = on_close,
    format = format,
    live = true,
  })
end

return M
