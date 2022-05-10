vim.g.nvim_tree_git_hl = 1
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
  git = {
    enable = false,
  },
  disable_netrw = false,
  open_on_setup = true,
  open_on_tab = false,
  auto_reload_on_write = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
  },
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  filters = {
    dotfiles = false,
    custom = { ".git", "node_modules", ".cache", ".DS_Store", "__pycache__", ".idea", ".dist" },
  },
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
    auto_resize = true,
    preserve_window_proportions = true,
  },
  show_icons = {
    git = 0,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 30,
  },
  root_folder_modifier = ":t",
  update_cwd = false,
})
