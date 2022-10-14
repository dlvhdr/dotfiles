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

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})

vim.cmd([[colorscheme tokyonight]])
