return {
  "luukvbaal/statuscol.nvim",
  config = function()
    require("statuscol").setup({
      setopt = true,
      separator = " ",
      order = "SNs",
    })
  end,
}
