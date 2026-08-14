return {
  "mistweaverco/kulala.nvim",
  event = { "SessionLoadPost", "VimLeavePre" },
  keys = {
    { "<leader>Rs", desc = "Send request" },
    { "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
    { "<leader>Ro", desc = "Open Kulala" },
  },
  enabled = true,
  ft = { "http", "rest", "javascript", "lua" },
  opts = {
    kulala_core = {
      data_dir = vim.fn.stdpath("data") .. "/kulala-core",
    },
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
    ui = {
      max_response_size = 1000000,
    },
  },
}
