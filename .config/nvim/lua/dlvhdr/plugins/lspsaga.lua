return {
  "glepnir/lspsaga.nvim",
  enabled = false,
  cmd = "Lspsaga",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("lspsaga").setup({
      ui = {
        border = "rounded",
        code_action = "",
        title = false,
        -- colors = {
        --   -- Normal background color for floating window
        --   normal_bg = "#1d1536",
        --   -- Title background color
        --   title_bg = "#afd700",
        --   red = "#e95678",
        --   magenta = "#b33076",
        --   orange = "#FF8700",
        --   yellow = "#f7bb3b",
        --   green = "#afd700",
        --   cyan = "#36d0e0",
        --   blue = "#61afef",
        --   purple = "#CBA6F7",
        --   white = "#d1d4cf",
        --   black = "#1c1c19",
        -- },
      },
      code_action = {
        keys = {
          quit = { "<ESC>", "q" },
        },
      },
      lighbulb = {
        enable = true,
        sign = true,
        enable_in_insert = true,
        sign_priority = 20,
        virtual_text = false,
      },
      finder = {
        edit = { "o", "<CR>" },
        vsplit = "s",
        split = "i",
        quit = { "q", "<ESC>" },
      },
      scroll_preview = {
        scroll_down = "<C-d>",
        scroll_up = "<C-u>",
      },
      rename = {
        quit = "<esc>",
      },
    })
  end,
}
