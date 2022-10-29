local status_ok, tokyonight = pcall(require, "tokyonight")
if not status_ok then
  return
end

local colors_ok, colors = pcall(require, "tokyonight.colors")
if not colors_ok then
  return
end
colors = colors.setup({})

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
  },
  dim_inactive = false,
  lualine_bold = false,
})

vim.cmd([[colorscheme tokyonight]])
