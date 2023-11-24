return {
  "linrongbin16/gitlinker.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("gitlinker").setup({})
  end,
  keys = {
    {
      "<leader>gym",
      function()
        local url = vim.fn.system("gh browse -n " .. vim.fn.expand("%") .. ":" .. vim.api.nvim_win_get_cursor(0)[1])
        vim.api.nvim_command("let @+ = '" .. url .. "'")
        vim.notify(url)
      end,
      desc = "Copy line URL (main)",
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
