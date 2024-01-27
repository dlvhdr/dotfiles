return {
  "chrisgrieser/nvim-genghis",
  dependencies = "stevearc/dressing.nvim",
  keys = {
    {
      "<leader>yp",
      function()
        require("genghis").copyFilepath()
      end,
    },
    {
      "<leader>yn",
      function()
        require("genghis").copyFilename()
      end,
    },
    {
      "<leader>df",
      function()
        require("genghis").trashFile()
      end,
    },
  },
}
