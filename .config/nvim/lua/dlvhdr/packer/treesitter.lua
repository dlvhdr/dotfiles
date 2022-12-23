local parsers_ok, parsers = pcall(require, "nvim-treesitter.parsers")
if not parsers_ok then
  return
end

local query_ok, _ = pcall(require, "nvim-treesitter.query_predicates")
if not query_ok then
  return
end

local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
if not configs_ok then
  return
end

configs.setup({
  context_commentstring = { enable = true },
  highlight = {
    enable = true,
    disable = function(_, bufnr)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
  query_linter = {
    enable = false,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
    is_supported = function(lang)
      return lang == "query" and parsers.has_parser("query")
    end,
  },
  playground = {
    enable = false,
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

local parser_config = parsers.get_parser_configs()
parser_config.markdown.filetype_to_parsername = "octo"
