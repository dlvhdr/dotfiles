local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
  return
end

local home = os.getenv("HOME")
local config = os.getenv("XDG_CONFIG_HOME")

dashboard.custom_header = {
  [[]],
  [[███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
  [[████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
  [[██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
  [[██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
  [[██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
  [[╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
}

dashboard.custom_center = {
  {
    icon = "  ",
    desc = "Last Session",
    action = function()
      require("persistence").load()
    end,
  },
  {
    icon = "  ",
    desc = "Open Personal dotfiles",
    action = function()
      require("telescope.builtin").find_files({ cwd = home .. "/dotfiles", hidden = true })
    end,
  },
}
dashboard.session_directory = config .. "/nvim/sessions"
dashboard.custom_footer = { "@dlvhdr" }

vim.api.nvim_command([[augroup Dashboard]])
vim.api.nvim_command([[autocmd!]])
vim.api.nvim_command(
  [[autocmd FileType dashboard setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell nolist nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs=]]
)
vim.api.nvim_command([[autocmd FileType dashboard set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2]])
vim.api.nvim_command([[autocmd FileType dashboard nnoremap <silent> <buffer> q :q<CR>]])
vim.api.nvim_command([[augroup END]])
