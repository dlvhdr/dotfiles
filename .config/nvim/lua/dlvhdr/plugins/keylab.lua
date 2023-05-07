return {
  "BooleanCube/keylab.nvim",
  lazy = true,
  cmd = "KeylabStart",
  consig = function()
    local keylab = require("keylab")
    keylab.setup({
      LINES = 15, -- 10 by default
      force_accuracy = false, -- true by default
      correct_fg = "#FFFFFF", -- #B8BB26 by default
      wrong_bg = "#000000", -- #FB4934 by default
    })
  end,
}
