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
    ---string to be shown at the start of winbar
    ---@type string
    prefix = " ",

    ---entry separator
    ---@type string
    separator = "",

    ---string to be shown when buffer is modified
    ---@type string
    modified = "●",

    ---string to be shown when context is available but empty
    ---@type string
    default_context = "…",
  },
})
