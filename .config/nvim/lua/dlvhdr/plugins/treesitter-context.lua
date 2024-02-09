return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesitter-context").setup({ enable = false })
  end,
  cmd = "TSContextToggle",
  init = function()
    vim.keymap.set("n", "[c", function()
      require("treesitter-context").go_to_context()
    end, { silent = true, desc = "Go to TS context" })
    vim.keymap.set("n", "<leader>cc", function()
      require("treesitter-context").toggle()
    end, { silent = true, desc = "[Toggle] TS Context" })
  end,
}
