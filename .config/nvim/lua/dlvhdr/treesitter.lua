local parsers = require("nvim-treesitter.parsers")
require("nvim-treesitter.query_predicates")

require("nvim-treesitter.configs").setup({
  context_commentstring = { enable = true },
  highlight = {
    enable = true,
    -- disable = function(lang, bufnr) -- Disable in large files
    --   return vim.api.nvim_buf_line_count(bufnr) > 3000
    -- end,
    additional_vim_regex_highlighting = false,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
    is_supported = function(lang)
      return lang == "query" and parsers.has_parser("query")
    end,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
  indent = {
    enable = true,
    disable = {},
  },
  autotag = {
    enable = true,
  },
  ensure_installed = "all",
})
