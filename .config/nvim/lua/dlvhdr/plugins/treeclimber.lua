return {
  "drybalka/tree-climber.nvim",
  dependecies = { "nvim-treesitter/nvim-treesitter" },
  event = "BufReadPost",
  init = function()
    local keyopts = { noremap = true, silent = true }
    vim.keymap.set({ "n", "v", "o" }, "H", require("tree-climber").goto_parent, keyopts)
    vim.keymap.set({ "n", "v", "o" }, "L", require("tree-climber").goto_child, keyopts)
    vim.keymap.set({ "v", "o" }, "in", require("tree-climber").select_node, keyopts)
  end,
}
