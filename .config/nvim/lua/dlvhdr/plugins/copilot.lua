local plugin = {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "Copilot",
  event = "InsertEnter",
}

function plugin.config()
  require("copilot").setup({
    panel = {
      auto_refresh = false,
      keymap = {
        accept = "<CR>",
        jump_prev = "[[",
        jump_next = "]]",
        refresh = "gr",
        open = "<M-CR>",
      },
    },
    suggestion = {
      auto_trigger = false,
      keymap = {
        accept = "<C-e>",
        accept_word = "<C-Right>",
        accept_line = "<C-Down>",
        prev = "<C-i>",
        next = "<C-u>",
        dismiss = "<C-]>",
      },
    },
  })
end

return plugin
