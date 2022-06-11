local colors = require("tokyonight.colors").setup({})
vim.api.nvim_set_hl(0, "TabLine", { fg = "#bbc2cf", bg = colors.black })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#bbc2cf", bg = colors.black })
vim.api.nvim_set_hl(0, "TabLineFill", { fg = "#c0caf5", bg = colors.black })
vim.api.nvim_set_hl(0, "TabLineCwd", { fg = "#7aa2f7", bg = colors.black, bold = true })

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
    cwd = cwd:gsub("/Users/dolevh/code/wix", "@wix")
    cwd = cwd:gsub("/Users/dolevh/code/personal/dotfiles", "@dotfiles")
    cwd = cwd:gsub("/Users/dolevh", "~")
    local bufname = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":.")
    bufname = bufname:gsub("/", "  ")
    local tabpagenr = vim.fn.tabpagenr()

    local is_selected = tabnr == tabpagenr

    -- local buffer_extension = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":e")
    -- local icon = require("nvim-web-devicons").get_icon(bufname, buffer_extension, { default = true })
    -- print(icon_color)
    -- local icon_highlight = color(icon_color, icon)

    local cwd_highlight = color("TabLineCwd", cwd)
    local buf_highlight = is_selected and color("TabLineSel", bufname) or color("TabLine", bufname)

    local segments = {}
    -- File modified
    if vim.fn.getbufvar(bufnr, "&modified") == 1 then
      table.insert(segments, color("BufferVisibleMod", ""))
    end

    -- Read only
    if vim.fn.getbufvar(bufnr, "&readonly") == 1 then
      table.insert(segments, color("StatuslineBoolean", ""))
    end

    table.insert(
      tabs,
      "%#TabLine#"
        .. cwd_highlight
        .. " "
        .. buf_highlight
        .. " "
        .. table.concat(segments, " ")
        .. "%#TabLine#"
    )
  end

  return table.concat(tabs, "")
end

vim.cmd([[set tabline=%!v:lua.tabline()]])
