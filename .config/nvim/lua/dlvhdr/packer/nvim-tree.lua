local status_ok, tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

tree.setup({
  renderer = {
    special_files = {
      "package.json",
      "README.md",
      "index.js",
      "index.ts",
      "index.tsx",
      "Makefile",
      "Cargo.toml",
    },
    root_folder_modifier = ":t",
    highlight_git = false,
    indent_markers = {
      enable = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        none = " ",
      },
    },
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "",
          renamed = "",
          untracked = "?",
          unmerged = "",
          deleted = "",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      },
      show = {
        git = false,
        folder = true,
        file = true,
        folder_arrow = false,
      },
    },
  },
  git = {
    enable = true,
    ignore = false,
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
    custom = {
      "^\\.git",
      "^\\.cache",
      "^\\.DS_Store",
      "__pycache__",
      "^\\.idea",
      "^\\.next",
      "node_modules",
      ".yarn",
      ".husky",
    },
    exclude = {
      "^dist",
    },
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
    remove_file = {
      close_window = false,
    },
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
    preserve_window_proportions = true,
    adaptive_size = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  update_cwd = false,
})
