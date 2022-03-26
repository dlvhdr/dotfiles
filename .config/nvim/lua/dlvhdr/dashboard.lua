vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_session_directory = "~/.config/nvim/sessions"
vim.g.dashboard_preview_command = "cat"
vim.g.dashboard_preview_pipeline = "lolcat --truecolor"
vim.g.dashboard_preview_file = "~/.config/nvim/neovim.cat"
vim.g.dashboard_preview_file_height = 11
vim.g.dashboard_preview_file_width = 80
vim.g.dashboard_custom_footer = { "@dlvhdr" }

vim.g.dashboard_custom_section = {
  a = {
    description = { "  Last Session        " },
    command = ":lua require('persistence').load()",
  },
  b = {
    description = { "  Find File          " },
    command = "Telescope find_files",
  },
  c = {
    description = { "  Recently Used Files" },
    command = "Telescope oldfiles",
  },
  d = {
    description = { "  Sync Plugins       " },
    command = "PackerSync",
  },
  e = {
    description = { "  New file            " },
    command = "DashboardNewFile",
  },
}

vim.api.nvim_command([[augroup Dashboard]])
vim.api.nvim_command([[autocmd!]])
vim.api.nvim_command(
  [[autocmd FileType dashboard setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell nolist nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs=]]
)
vim.api.nvim_command([[autocmd FileType dashboard set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2]])
vim.api.nvim_command([[autocmd FileType dashboard nnoremap <silent> <buffer> q :q<CR>]])
vim.api.nvim_command([[augroup END]])

vim.g.indent_blankline_filetype_exclude = "['dashboard']"
