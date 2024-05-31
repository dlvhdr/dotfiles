return {
  "dmmulroy/tsc.nvim",
  cmd = "TSC",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("tsc").setup({
      enable_progress_notifications = true,
      hide_progress_notifications_from_history = true,
      auto_open_qflist = true,
      use_trouble_qflist = true,
    })
  end,
}
