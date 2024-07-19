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
    vim.keymap.set("n", "<leader>lc", function()
      require("treesitter-context").toggle()
    end, { silent = true, desc = "Treesitter Context" })

    local wk = require("which-key")
    wk.add({
      { "<leader>lc", icon = "󰨚 " },
    })
  end,
}
