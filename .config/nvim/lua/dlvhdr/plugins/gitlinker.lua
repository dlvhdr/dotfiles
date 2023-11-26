return {
  "linrongbin16/gitlinker.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("gitlinker").setup({
      router = {
        main_branch = {
          ["^github%.com"] = "https://github.com/"
            .. "{_A.USER}/"
            .. "{_A.REPO}/blob/main/" -- always 'main' branch
            .. "{_A.FILE}"
            .. "?&lines={_A.LSTART}"
            .. "{_A.LEND > _A.LSTART and ('&lines-count=' .. _A.LEND - _A.LSTART + 1) or ''}",
        },
        master_branch = {
          ["^github%.com"] = "https://github.com/"
            .. "{_A.USER}/"
            .. "{_A.REPO}/blob/master/" -- always 'master' branch
            .. "{_A.FILE}"
            .. "?&lines={_A.LSTART}"
            .. "{_A.LEND > _A.LSTART and ('&lines-count=' .. _A.LEND - _A.LSTART + 1) or ''}",
        },
      },
    })
  end,
  keys = {
    {
      "<leader>gym",
      "<cmd>GitLink main_branch<cr>",
      desc = "Copy line URL (main)",
      mode = { "n", "v" },
    },
    {
      "<leader>gyM",
      "<cmd>GitLink master_branch<cr>",
      desc = "Copy line URL (master)",
      mode = { "n", "v" },
    },
    {
      "<leader>gyc",
      "<cmd>GitLink<cr>",
      desc = "Copy line URL (commit)",
      mode = { "n", "v" },
    },
    {
      "<leader>gyb",
      function()
        local branch = vim.fn.system("git branch --show-current")

        local url = vim.fn.system(
          "gh browse -n " .. vim.fn.expand("%") .. ":" .. vim.api.nvim_win_get_cursor(0)[1] .. " --branch " .. branch
        )
        vim.api.nvim_command("let @+ = '" .. url .. "'")
        vim.notify(url)
      end,
      desc = "Copy line URL (branch)",
    },
    {
      "<leader>gB",
      "<cmd>GitLink! blame<cr>",
      desc = "GitHub Blame",
      mode = { "v", "n" },
    },
  },
}
