local M = {
  "folke/which-key.nvim",
}

M.config = function()
  local wk = require("which-key")

  wk.setup({
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "→", -- symbol used between a key and it's label
      group = " ", -- symbol prepended to a group
    },
    show_help = false,
    show_keys = false,
  })
  local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }
  wk.register({
    ["*"] = "which_key_ignore",
    f = {
      name = "Telescope",
    },
    g = {
      name = "Git",
      d = {
        name = "Diff",
      },
    },
    d = {
      name = "DAP",
    },
    h = {
      name = "Gitsigns",
      t = {
        name = "Toggle",
      },
    },
    a = {
      name = "Document",
    },
    x = {
      name = "Trouble",
    },
    o = {
      name = "Octo",
    },
    t = {
      name = "Toggle",
    },
    s = {
      name = "Replace",
    },
    ["<tab>"] = {
      name = "tab",
    },
  }, opts)
end

return M
