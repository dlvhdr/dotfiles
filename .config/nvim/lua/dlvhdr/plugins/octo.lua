return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-treesitter",
    "folke/tokyonight.nvim",
  },
  cmd = "Octo",
  config = function()
    local status_ok, octo = pcall(require, "octo")
    if not status_ok then
      return
    end

    octo.setup()
  end,
}
