vim.cmd("hi TabLine guifg=#bbc2cf guibg=#1f2335")
vim.cmd("hi TabLineSel guifg=#bbc2cf guibg=#1f2335")
vim.cmd("hi TabLineFill guibg=#1f2335 guifg=#c0caf5")
vim.cmd("hi TabLineCwd guifg=#7aa2f7 guibg=#3b4261 gui=bold ")

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
    local cwd = "  " .. vim.fn.getcwd(winnr, tabnr) .. " "
    cwd = cwd:gsub("/Users/dolevh/code/wix", "@wix")
    cwd = cwd:gsub("/Users/dolevh/code/personal/dotfiles", "@dotfiles")
    cwd = cwd:gsub("/Users/dolevh", "~")
    local bufname = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":.")
    local buffer_extension = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":e")
    local tabpagenr = vim.fn.tabpagenr()

    local is_selected = tabnr == tabpagenr

    local segments = {}
    -- File modified
    if vim.fn.getbufvar(bufnr, "&modified") == 1 then
      table.insert(segments, color("WarningMsg", " "))
    end

    -- Read only
    if vim.fn.getbufvar(bufnr, "&readonly") == 1 then
      table.insert(segments, color("StatuslineBoolean", ""))
    end

    local icon, icon_color = require("nvim-web-devicons").get_icon(bufname, buffer_extension, { default = true })
    local icon_highlight = color(icon_color, icon)

    local cwd_highlight = color("TabLineCwd", cwd)
    local buf_highlight = is_selected and color("TabLineSel", bufname) or color("TabLine", bufname)

    table.insert(
      tabs,
      " " .. cwd_highlight .. " " .. table.concat(segments, " ") .. icon_highlight .. " " .. buf_highlight
    )
  end

  return table.concat(tabs, "")
end

vim.cmd([[set tabline=%!v:lua.tabline()]])

-- vim.cmd([[
--     :set tabline=%!TabLine()
--
--     function TabLine()
--     let s = ''
--     " loop through each tab page
--     for i in range(tabpagenr('$'))
--         if i + 1 == tabpagenr()
--             let s .= '%#TabLineSel#'
--         else
--             let s .= '%#TabLine#'
--         endif
--         " set the tab page number
--         let s .= '%' . (i + 1) . 'T '
--         " set page number string
--         let s .= i + 1 . ''
--         " get buffer names and statuses
--         let n = ''  " temp str for buf names
--         let buflist = tabpagebuflist(i + 1)
--         " loop through each buffer in a tab
--         for b in buflist
--         endfor
--         let n .= bufname(buflist[tabpagewinnr(i + 1) - 1])
--         let n = substitute(n, ', $', '', '')
--         let n = substitute(n, '^\.\/', '', '')
--         let n = substitute(n, '^/Users/dolevh/code/wix', '@wix', '')
--         " add modified label
--         if i + 1 == tabpagenr()
--             let s .= ' %#TabLineSel#'
--         else
--             let s .= ' %#TabLine#'
--         endif
--         " add buffer names
--         if n == ''
--             let s .= '[New Buffer]'
--         else
--             let s .= n
--         endif
--         " switch to no underlining and add final space
--         let s .= ' '
--     endfor
--     let s .= '%#TabLineFill#%T'
--     return s
--     endfunction
-- ]])
--
