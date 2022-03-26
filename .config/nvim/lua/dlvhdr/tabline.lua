vim.cmd([[
    :set tabline=%!TabLine()

    function TabLine()
    let s = ''
    " loop through each tab page
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " set the tab page number
        let s .= '%' . (i + 1) . 'T '
        " set page number string
        let s .= i + 1 . ''
        " get buffer names and statuses
        let n = ''  " temp str for buf names
        let buflist = tabpagebuflist(i + 1)
        " loop through each buffer in a tab
        for b in buflist
        endfor
        let n .= bufname(buflist[tabpagewinnr(i + 1) - 1])
        let n = substitute(n, ', $', '', '')
        let n = substitute(n, '^\.\/', '', '')
        let n = substitute(n, '^/Users/dolevh/code/wix', '@wix', '')
        " add modified label
        if i + 1 == tabpagenr()
            let s .= ' %#TabLineSel#'
        else
            let s .= ' %#TabLine#'
        endif
        " add buffer names
        if n == ''
            let s .= '[New Buffer]'
        else
            let s .= n
        endif
        " switch to no underlining and add final space
        let s .= ' '
    endfor
    let s .= '%#TabLineFill#%T'
    return s
    endfunction
]])

vim.cmd("hi TabLine guibg=#1f2335 guifg=#979fc2")
vim.cmd("hi TabLineSel guibg=#1f2335 guifg=#c0caf5")
vim.cmd("hi TabLineFill guibg=#1f2335 guifg=#c0caf5")
