local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

M.config = function()
  local wk = require("which-key")

  wk.setup({
    preset = "helix",
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "→", -- symbol used between a key and it's label
      group = "", -- symbol prepended to a group
    },
    win = {
      padding = { 1, 0 }, -- extra window padding [top/bottom, right/left]
    },
    modes = {
      n = true, -- Normal mode
      i = true, -- Insert mode
      x = true, -- Visual mode
      s = true, -- Select mode
      o = false, -- Operator pending mode
      t = true, -- Terminal mode
      c = true, -- Command mode
    },
    -- sort = { "local", "order", "group", "alphanum", "mod", "lower", "icase" },
    sort = { "lower", "group" },
    notify = false,
    show_help = false,
    show_keys = false,
    plugins = {
      marks = false,
      registers = false,
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
  })
  local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }
  wk.add({
    { "<leader>*", hidden = true, nowait = false, remap = false },
    { "<leader><Tab>", group = "Tabs", icon = "󰓩 ", nowait = false, remap = false },
    { "<leader>b", group = "Buffers", icon = " ", nowait = false, remap = false },
    { "<leader>c", group = "Code", icon = " ", nowait = false, remap = false },
    { "<leader>d", group = "Debug", icon = " ", nowait = false, remap = false },
    { "<leader>f", group = "Telescope", icon = " ", nowait = false, remap = false },
    { "<leader>g", group = "Git", icon = "󰊢 ", nowait = false, remap = false },
    { "<leader>gd", group = "Diff", icon = " ", nowait = false, remap = false },
    { "<leader>gy", group = "Copy URLs", icon = " ", nowait = false, remap = false },
    { "<leader>h", group = "Gitsigns", icon = " ", nowait = false, remap = false },
    { "<leader>ht", group = "Toggle", icon = " ", nowait = false, remap = false },
    { "<leader>l", group = "LSP", icon = "󱌢 ", nowait = false, remap = false },
    { "<leader>o", group = "Octo", icon = " ", nowait = false, remap = false },
    { "<leader>t", group = "Test", icon = " ", nowait = false, remap = false },
    { "<leader>x", group = "Trouble", icon = " ", nowait = false, remap = false },
  }, opts)
end

return M
