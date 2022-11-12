local M = {}

M.setup = function()
  local status_ok, tokyonight = pcall(require, "tokyonight")
  if not status_ok then
    return
  end

  M.tokyonight = tokyonight

  local colors_ok, colors = pcall(require, "tokyonight.colors")
  if not colors_ok then
    return
  end
  colors = colors.setup({})
  M.colors = colors

  local util_ok, util = pcall(require, "tokyonight.util")
  if not util_ok then
    return
  end
  M.util = util

  tokyonight.setup({
    style = "storm",
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "dark",
      floats = "normal",
    },
    sidebars = {
      "terminal",
      "packer",
      "help",
      "NvimTree",
      "Trouble",
      "LspInfo",
    },
    dim_inactive = false,
    lualine_bold = false,
  })

  vim.cmd([[colorscheme tokyonight]])
end

return M
