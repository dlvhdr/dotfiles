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
      "<leader>fM",
      "<cmd>Grapple open_tags<cr>",
      desc = "Open Grapple Tags",
    },
  },
  config = function()
    require("grapple").setup({})
  end,
}
