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

local function color(highlight_group, content)
  return "%#" .. highlight_group .. "#" .. content .. "%*"
end

function _G.tabline()
  local tabs = {}

  for i = 1, vim.fn.tabpagenr("$") do
    local tabnr = i
    local winnr = vim.fn.tabpagewinnr(tabnr)
    local buflist = vim.fn.tabpagebuflist(tabnr)
    local bufnr = buflist[winnr]
    local cwd = vim.fn.getcwd(winnr, tabnr) .. ""
    cwd = cwd:gsub("/Users/dolevh/code/wix/wix%-code%-devex%-mono", "@devex")
    cwd = cwd:gsub("/Users/dolevh/code/wix", "@wix")
    cwd = cwd:gsub("/Users/dolevh/dotfiles", "@dotfiles")
    cwd = cwd:gsub("/Users/dolevh", "~")
    local buf_path = vim.fn.bufname(bufnr)
    local bufname = vim.fn.fnamemodify(buf_path, ":~:.")
    bufname = bufname:gsub(vim.fn.getcwd(winnr, tabnr), cwd)
    vim.api.nvim_set_hl(0, "BufNameSeparator", { fg = "#9d7cd8", bg = colors.black })
    bufname = bufname:gsub("/", "%%#BufNameSeparator#  %%*")

    local bufname_tail = vim.fn.fnamemodify(buf_path, ":t")
    local devicon, devicon_color = devicons.get_icon_color_by_filetype(vim.bo.filetype, { default = true })
    vim.api.nvim_set_hl(0, "TabLineFileIcon", { fg = devicon_color, bg = colors.black })
    bufname = bufname:gsub(bufname_tail .. "$", "%%#TabLineFileIcon#" .. devicon .. "%%* " .. bufname_tail)

    local segments = {}
    -- File modified
    if bufname ~= "" then
      if vim.fn.getbufvar(bufnr, "&modified") == 1 then
        table.insert(segments, color("BufferVisibleMod", "●"))
      end
    end

    -- Read only
    if vim.fn.getbufvar(bufnr, "&readonly") == 1 then
      table.insert(segments, color("StatuslineBoolean", ""))
    end

    local main = "%#TabLine#" --[[.. cwd_highlight .. " "--]]
      .. table.concat(segments, " ")
      .. " "
      .. bufname
      .. " "
      .. "%#TabLine#"

    table.insert(tabs, main)
    -- table.insert(tabs, string.rep(".", vim.go.columns - vim.fn.winwidth(0)))
  end

  return table.concat(tabs, "")
end

vim.cmd([[set tabline=%!v:lua.tabline()]])
