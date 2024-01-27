return {
  "ThePrimeagen/harpoon",
  enabled = false,
  lazy = true,
  keys = {
    { "<Leader>ha", ':lua require("harpoon.mark").add_file()<CR>', desc = "Add File" },
    { "<Leader>hh", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', desc = "Toggle Quick Menu" },
  },
  opts = {
    excluded_filetypes = { "harpoon" },
  },
}
