return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({
      default = true,
      override = {
        default_icon = {
          icon = "",
          color = "#c0caf5",
          cterm_color = "65",
          name = "Default",
        },
      },
    })
  end,
}
