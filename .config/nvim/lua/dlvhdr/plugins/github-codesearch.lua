return {
  "napisani/nvim-github-codesearch",
  build = "make",
  keys = {
    {
      "<leader>gs",
      function()
        local gh_search = require("nvim-github-codesearch")
        gh_search.prompt()
      end,
      desc = "Search code on GitHub",
    },
  },
  config = function()
    local token = vim.fn.system("gh auth token")
    token = string.gsub(token or "", "\n", "")
    local gh_search = require("nvim-github-codesearch")

    ---@diagnostic disable-next-line: missing-fields
    gh_search.setup({
      github_auth_token = token,
      use_telescope = true,
    })
  end,
}
