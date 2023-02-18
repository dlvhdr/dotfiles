return {
  "luukvbaal/statuscol.nvim",
  event = "BufReadPre",
  config = function()
    require("statuscol").setup({
      setopt = true,
      separator = " ",
      order = "SNsFs",
      foldfunc = "builtin",
    })
  end,
}
