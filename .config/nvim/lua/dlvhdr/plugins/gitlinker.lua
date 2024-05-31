return {
  "linrongbin16/gitlinker.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("gitlinker").setup({
      --   router = {
      --     default_branch = {
      --       ["^github%.com"] = "https://github.com/"
      --         .. "{_A.USER}/"
      --         .. "{_A.REPO}/blob/"
      --         .. "{_A.DEFAULT_BRANCH}/" -- always 'master'/'main' branch
      --         .. "{_A.FILE}?plain=1" -- '?plain=1'
      --         .. "#L{_A.LSTART}"
      --         .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
      --     },
      --     current_branch = {
      --       ["^github%.com"] = "https://github.com/"
      --         .. "{_A.USER}/"
      --         .. "{_A.REPO}/blob/"
      --         .. "{_A.CURRENT_BRANCH}/" -- always current branch
      --         .. "{_A.FILE}?plain=1" -- '?plain=1'
      --         .. "#L{_A.LSTART}"
      --         .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
      --     },
      --     blame_default_branch = {
      --       ["^github%.com"] = "https://github.com/"
      --         .. "{_A.USER}/"
      --         .. "{_A.REPO}/blame/"
      --         .. "{_A.DEFAULT_BRANCH}/"
      --         .. "{_A.FILE}?plain=1" -- '?plain=1'
      --         .. "#L{_A.LSTART}"
      --         .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
      --     },
      --   },
    })
  end,
  keys = {
    {
      "<leader>gym",
      "<cmd>GitLink default_branch<cr>",
      desc = "Copy line URL (main branch)",
      mode = { "n", "v" },
    },
    {
      "<leader>gyb",
      "<cmd>GitLink current_branch<cr>",
      desc = "Copy line URL (current branch)",
      mode = { "n", "v" },
    },
    {
      "<leader>gyc",
      "<cmd>GitLink<cr>",
      desc = "Copy line URL (commit)",
      mode = { "n", "v" },
    },
    {
      "<leader>gB",
      "<cmd>GitLink! blame_default_branch<cr>",
      desc = "GitHub Blame (main branch)",
      mode = { "v", "n" },
    },
  },
}
