local plugin = {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "Copilot",
  event = "InsertEnter",
  enabled = false,
}

function plugin.config()
  require("copilot").setup({
    panel = {
      auto_refresh = false,
      keymap = {
        accept = "<CR>",
        jump_prev = "[[",
        jump_next = "]]",
        open = "<M-CR>",
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<C-e>",
        accept_word = "<C-Right>",
        accept_line = false,
        next = "<C-space>",
        dismiss = "<C-c>",
      },
    },
  })
end

return plugin
