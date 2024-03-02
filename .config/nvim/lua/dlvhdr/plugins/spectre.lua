return {
  "nvim-pack/nvim-spectre",
  cmd = "Spectre",
  keys = {
    {
      "<leader>cR",
      function()
        require("spectre").open()
      end,
      desc = " Replace in files (Spectre)",
    },
  },
}
