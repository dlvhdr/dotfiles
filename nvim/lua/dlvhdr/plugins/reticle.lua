-- Plugin to highlight only the screen line of the cursor in the currently active window
return {
  "tummetott/reticle.nvim",
  event = "BufReadPre",
  config = function()
    require("reticle").setup({
      ignore = {
        cursorline = {
          "DressingInput",
          "FTerm",
          "NvimSeparator",
          "NvimTree",
          "TelescopePrompt",
          "Trouble",
          "noice",
        },
      },
    })
  end,
}
