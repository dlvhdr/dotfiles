require("nvim-treesitter.configs").setup({
  context_commentstring = { enable = true },
  highlight = {
    enable = true,
    disable = function(lang, bufnr) -- Disable in large files
      return vim.api.nvim_buf_line_count(bufnr) > 3000
    end,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = "all",
})
