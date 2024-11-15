vim.filetype.add({
  extension = {
    mdx = "markdown",
  },
})
vim.treesitter.language.register("markdown", "mdx")
