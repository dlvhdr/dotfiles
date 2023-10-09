return {
  "stevearc/dressing.nvim",
  lazy = true,
  config = function()
    require("dressing").setup({
      input = {
        win_options = {
          winhighlight = "NormalFloat:DiagnosticError",
        },
      },
    })
  end,
}
