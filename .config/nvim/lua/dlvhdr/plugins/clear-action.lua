return {
  "luckasRanarison/clear-action.nvim",
  Event = "LspAttach",
  config = function()
    require("clear-action").setup({
      signs = {
        enable = true,
      },
      mappings = {
        code_action = "ga",
      },
    })
  end,
}
