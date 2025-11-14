return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  config = function()
    local persistence = require("persistence")
    persistence.setup({
      options = { "buffers", "curdir", "winsize" },
      branch = true,
    })
  end,
}
