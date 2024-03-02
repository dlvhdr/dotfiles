return {
  "chrisgrieser/nvim-genghis",
  dependencies = "stevearc/dressing.nvim",
  keys = {
    {
      "<leader>yp",
      function()
        require("genghis").copyFilepath()
      end,
      desc = "Copy file path",
    },
    {
      "<leader>yn",
      function()
        require("genghis").copyFilename()
      end,
      desc = "Copy file name",
    },
  },
  init = function()
    local wk = require("which-key")
    wk.register({
      ["<leader>y"] = {
        name = " Copy",
      },
    })
  end,
}
