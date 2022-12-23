local colors_status_ok, colors = pcall(require, "tokyonight.colors")
if not colors_status_ok then
  return
end
colors = colors.setup({})

local devicons_status_ok, devicons = pcall(require, "nvim-web-devicons")
if not devicons_status_ok then
  return
end

vim.api.nvim_set_hl(0, "TabLine", { fg = colors.fg_dark, bg = colors.bg_dark })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = colors.fg_dark, bg = colors.bg_dark })
vim.api.nvim_set_hl(0, "TabLineFill", { fg = colors.fg_dark, bg = colors.bg_dark })
vim.api.nvim_set_hl(0, "TabLineCwd", { fg = colors.fg_dark, bg = colors.bg_dark })
vim.api.nvim_set_hl(0, "BufNameSeparator", { fg = "#9d7cd8", bg = colors.bg_dark })
vim.api.nvim_set_hl(0, "TabPage", { fg = colors.comment, bg = colors.black })
vim.api.nvim_set_hl(0, "TabPageCurrent", { fg = colors.fg, bg = colors.black, bold = true })

local function color(highlight_group, content)
  return "%#" .. highlight_group .. "#" .. content .. "%*"
end

local function remove_highlight_strings(str)
  return str:gsub("%%#%a*#%*?", ""):gsub("%%%*", "")
end

function _G.tabline()
  local tabline = {}

  local tabnr = vim.api.nvim_tabpage_get_number(0)
  local winnr = vim.fn.tabpagewinnr(tabnr)
  local buflist = vim.fn.tabpagebuflist(tabnr)
  local bufnr = buflist[winnr]

  local cwd = vim.fn.getcwd(winnr, tabnr) .. ""
  cwd = cwd:gsub("/Users/dolevh/code/wix/wix%-code%-devex%-mono", "@devex")
  cwd = cwd:gsub("/Users/dolevh/code/wix", "@wix")
  cwd = cwd:gsub("/Users/dolevh/dotfiles", "@dotfiles")
  cwd = cwd:gsub("/Users/dolevh", "~")

  local buf_path = vim.fn.bufname(bufnr)
  local bufname = ""
  if buf_path:match("^%a*://") then
    bufname = vim.fn.fnamemodify(buf_path, ":t")
  else
    bufname = vim.fn.fnamemodify(buf_path, ":~:.")
    bufname = bufname:gsub(vim.fn.getcwd(winnr, tabnr), cwd)
    bufname = bufname:gsub("/", "%%#BufNameSeparator#  %%*")
  end

  local bufname_tail = vim.fn.fnamemodify(buf_path, ":t")
  local devicon, devicon_color = devicons.get_icon_color_by_filetype(vim.bo.filetype, { default = true })
  vim.api.nvim_set_hl(0, "TabLineFileIcon", { fg = devicon_color, bg = colors.bg_dark })
  bufname = bufname:gsub(bufname_tail .. "$", "%%#TabLineFileIcon#" .. devicon .. "%%* " .. bufname_tail)

  local segments = {}
  if bufname ~= "" then
    if vim.fn.getbufvar(bufnr, "&modified") == 1 then
      table.insert(segments, color("BufferVisibleMod", "●"))
    end
  end

  if vim.fn.getbufvar(bufnr, "&readonly") == 1 then
    table.insert(segments, color("StatuslineBoolean", ""))
  end

  local main = "%#TabLine#" .. table.concat(segments, " ") .. " " .. bufname .. " " .. "%#TabLine#"

  local tabs = {}
  for tab in pairs(vim.api.nvim_list_tabpages()) do
    if tab == tabnr then
      table.insert(tabs, "%#TabPageCurrent# " .. tab .. " %*")
    else
      table.insert(tabs, "%#TabPage# " .. tab .. " %*")
    end
  end

  local main_width_str = remove_highlight_strings(main)
  local main_width = vim.fn.strwidth(main_width_str)

  local rendered_tabs = table.concat(tabs, "")
  local tabs_width_str = remove_highlight_strings(rendered_tabs)
  local tabs_width = vim.fn.strwidth(tabs_width_str)

  table.insert(tabline, main)
  table.insert(tabline, string.rep(" ", vim.go.columns - main_width - tabs_width))
  table.insert(tabline, rendered_tabs)

  return table.concat(tabline, "")
end

-- vim.cmd([[set tabline=%!v:lua.tabline()]])
