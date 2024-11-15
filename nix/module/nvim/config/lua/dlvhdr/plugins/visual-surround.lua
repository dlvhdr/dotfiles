return {
  "NStefan002/visual-surround.nvim",
  event = "BufReadPost",
  config = function()
    require("visual-surround").setup({
      surround_chars = { "[", "]", "(", ")", "'", '"', "`" },
    })
  end,
}
