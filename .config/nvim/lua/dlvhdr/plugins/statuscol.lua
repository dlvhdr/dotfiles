return {
  "luukvbaal/statuscol.nvim",
  event = "BufReadPre",
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      setopt = true,
      separator = "",
      relculright = true,
      segments = {
        { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
        {
          sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
          click = "v:lua.ScSa",
        },
        {
          text = { builtin.lnumfunc, " " },
          click = "v:lua.ScLa",
        },
        {
          sign = { name = { "GitSigns" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
          click = "v:lua.ScSa",
        },
      },
    })
  end,
}
