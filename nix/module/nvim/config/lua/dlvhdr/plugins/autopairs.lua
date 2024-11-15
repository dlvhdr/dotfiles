return {
  "windwp/nvim-autopairs",
  dependencies = {
    "iguanacucumber/magazine.nvim",
  },
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup({
      check_ts = true,
      disable_filetype = { "TelescopePrompt" },
      ts_config = {
        lua = { "string", "comment" }, -- it will not add a pair on that treesitter node
      },
    })
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
  end,
}
