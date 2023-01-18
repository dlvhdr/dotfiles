return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesitter-context").setup({ enable = false })
  end,
  cmd = "TSContextToggle",
  keys = {
    {
      "<leader>tc",
      function()
        local context = require("treesitter-context")
        context.toggle()
        vim.api.nvim_create_autocmd({ "CursorMoved" }, {
          buffer = vim.api.nvim_get_current_buf(),
          callback = function()
            context.disable()
            return true
          end,
        })
      end,
      desc = "Toggle Context",
    },
  },
}
