return {
  "tpope/vim-fugitive",
  cmd = "Git",
  keys = {
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    {
      "<leader>gB",
      function()
        local url = require("gitlinker").get_buf_range_url("n", {
          print_url = false,
          action_callback = function(url)
            return url
          end,
        })
        if url == nil then
          vim.notify("No url found")
          return
        end
        url = url:gsub("blob", "blame")
        vim.api.nvim_command("let @+ = '" .. url .. "'")
        vim.notify(url)
      end,
      desc = "GitHub Blame",
    },
    { "<leader>go", "<cmd>Git browse<cr>", desc = "Open Repo GitHub" },
  },
}
