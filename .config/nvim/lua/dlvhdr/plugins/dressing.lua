return {
  "stevearc/dressing.nvim",
  event = { "BufReadPre", "BufNewFile" },
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
