vim.g.sense_nvim = {
  presets = {
    virtualtext = {
      enabled = false,
    },
    statuscolumn = {
      enabled = true,
    },
  },
}
return {
  "boltlessengineer/sense.nvim",
  event = "LspAttach",
}
