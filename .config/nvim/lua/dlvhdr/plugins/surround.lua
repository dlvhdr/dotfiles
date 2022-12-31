return {
  "kylechui/nvim-surround",
  event = "InsertEnter",
  config = function()
    require("nvim-surround").setup({})
  end,
}
