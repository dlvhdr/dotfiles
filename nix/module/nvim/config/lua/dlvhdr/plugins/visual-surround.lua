return {
  "NStefan002/visual-surround.nvim",
  event = "BufReadPost",
  config = function()
    require("visual-surround").setup({
      surround_chars = { "[", "]", "(", ")", "'", '"', "`" },
    })

    vim.keymap.set("v", "sc", function()
      require("visual-surround").surround("{")
    end)
    vim.keymap.set("v", "sp", function()
      require("visual-surround").surround("(")
    end)
    vim.keymap.set("v", "sb", function()
      require("visual-surround").surround("[")
    end)
    vim.keymap.set("v", "st", function()
      require("visual-surround").surround("`")
    end)
    vim.keymap.set("v", "sq", function()
      require("visual-surround").surround('"')
    end)
    vim.keymap.set("v", "ss", function()
      require("visual-surround").surround("'")
    end)
  end,
}
