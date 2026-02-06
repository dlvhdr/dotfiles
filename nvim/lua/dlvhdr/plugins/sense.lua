-- sense.nvim shows diagnostics that are not visible in current view with their distance.
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
