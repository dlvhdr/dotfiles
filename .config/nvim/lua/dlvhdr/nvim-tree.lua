vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "",
    renamed = "",
    untracked = "?",
    unmerged = "",
    deleted = "",
    ignored = "",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

require("nvim-tree").setup({
  disable_netrw = true,
  open_on_setup = false,
  open_on_tab = false,
  auto_reload_on_write = true,
  update_focused_file = {
    enable = true,
  },
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  tree_ignore = { ".git", ".cache" },
  hide_dotfiles = false,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  actions = {
    open_file = {
      resize_window = true,
      quit_on_open = false,
      window_picker = {
        enable = false,
      },
    },
  },
  view = {
    width = 35,
    side = "right",
    mappings = {
      custom_only = false,
    },
  },
  show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 30,
  },
  git_hl = 1,
  disable_window_picker = 0,
  root_folder_modifier = ":t",
  update_cwd = false,
})
