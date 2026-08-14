vim.filetype.add({
  extension = {
    mdx = "markdown",
    keymap = "dts",
  },
})
vim.treesitter.language.register("markdown", "mdx")
