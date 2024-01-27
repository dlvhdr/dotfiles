local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "RRethy/nvim-treesitter-textsubjects",
    "nvim-treesitter/nvim-treesitter-refactor",
    "mfussenegger/nvim-treehopper",
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
    "andymass/vim-matchup",
  },
}

M.config = function()
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

  ---@diagnostic disable: missing-fields
  configs.setup({
    sync_install = false,
    auto_install = true,
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "typescript",
      "javascript",
      "html",
      "css",
      "json",
      "yaml",
      "bash",
      "dockerfile",
      "go",
      "java",
      "jsonc",
      "lua",
      "regex",
      "ruby",
      "scss",
      "tsx",
      "yaml",
      "ninja",
      "python",
      "rst",
      "toml",
    },
    modules = {},
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
    textsubjects = {
      enable = true,
      prev_selection = ",",
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
        ["i;"] = "textsubjects-container-inner",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = { ["]f"] = "@function.outer" },
        goto_next_end = { ["]F"] = "@function.outer" },
        goto_previous_start = { ["[f"] = "@function.outer" },
        goto_previous_end = { ["[F"] = "@function.outer" },
      },
    },
    matchup = {
      enable = true,
      disable_virtual_text = true,
    },
  })

  local parser_config = parsers.get_parser_configs()
  parser_config.markdown.filetype_to_parsername = "octo"

  vim.g.skip_ts_context_commentstring_module = true
  require("ts_context_commentstring").setup({
    enable_autocmd = false,
  })

  vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

return M
