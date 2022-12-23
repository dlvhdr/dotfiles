local M = {
  "glepnir/dashboard-nvim",
}

M.config = function()
  local status_ok, dashboard = pcall(require, "dashboard")
  if not status_ok then
    return
  end

  local home = os.getenv("HOME")
  local config = os.getenv("XDG_CONFIG_HOME")

  dashboard.custom_header = {
    "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
    "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
    "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
    "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
    "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
    "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
    "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
    " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
    " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
    "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
    "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
  }

  local colors_status_ok, colors = pcall(require, "tokyonight.colors")
  if not colors_status_ok then
    return
  end

  colors = colors.setup({})
  vim.cmd("hi! DashboardHeader guibg=none guifg=" .. colors.dark3)

  dashboard.custom_center = {
    {
      icon = "  ",
      desc = "Last Session",
      action = "silent lua require('persistence').load()",
      silent = true,
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

  -- local plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
  -- dashboard.custom_footer = { " Loaded " .. plugins_count .. " plugins", "@dlvhdr" }

  vim.api.nvim_command([[augroup Dashboard]])
  vim.api.nvim_command([[autocmd!]])
  vim.api.nvim_command(
    [[autocmd FileType dashboard setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell nolist nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs=]]
  )
  vim.api.nvim_command([[autocmd FileType dashboard set showtabline=0 | autocmd BufLeave <buffer> set showtabline=1]])
  vim.api.nvim_command([[autocmd FileType dashboard nnoremap <silent> <buffer> q :q<CR>]])
  vim.api.nvim_command([[augroup END]])
end

return M
