return {
  "luukvbaal/statuscol.nvim",
  event = "BufReadPre",
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      setopt = true,
      separator = "",
      foldfunc = "builtin",
      segments = {
        { text = { "%s" }, click = "v:lua.ScSa" },
        {
          text = { builtin.lnumfunc, " " },
          click = "v:lua.ScLa",
        },
      },
    })
  end,
}
