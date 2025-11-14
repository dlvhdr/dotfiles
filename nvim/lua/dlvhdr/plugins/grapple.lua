return {
  "cbochs/grapple.nvim",
  cmd = "Grapple",
  keys = {
    {
      "<leader>fm",
      "<cmd>Grapple toggle<cr>",
      desc = "Toggle Grapple",
    },
    {
      "<leader>fo",
      "<cmd>Grapple open_tags<cr>",
      desc = "Open Grapple Tags",
    },
  },
  config = function()
    require("grapple").setup({ win_opts = {
      width = 120,
    } })
  end,
}
