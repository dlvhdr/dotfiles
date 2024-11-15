return {
  "stevearc/dressing.nvim",
  event = { "BufReadPost", "BufNewFile" },
  enabled = true,
  config = function()
    require("dressing").setup({
      input = {
        override = function(conf)
          conf.col = -1
          conf.row = 0
          return conf
        end,
        insert_only = false,
        start_in_insert = true,
        border = "rounded",
        prefer_width = 60,
        min_width = { 60, 0.2 },
      },
    })
  end,
}
