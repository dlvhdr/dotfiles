return {
  "dlvhdr/gh-blame.nvim",
  dir = "/Users/dlvhdr/code/personal/gh-blame.nvim",
  enabled = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local ghb = require("gh-blame")
    ghb.setup({})
    ghb.hello()
  end,
}
