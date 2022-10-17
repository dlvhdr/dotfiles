local status_ok, barbecue = pcall(require, "barbecue")
if not status_ok then
  return
end

local colors_status_ok, colors = pcall(require, "tokyonight.colors")
if not colors_status_ok then
  return
end

colors = colors.setup({})

vim.cmd("hi! NavicSeparator guibg=none guifg=" .. colors.dark3)

barbecue.setup({
  symbols = {
    prefix = " ",
    separator = "",
    modified = "●",
    default_context = "…",
  },
})
