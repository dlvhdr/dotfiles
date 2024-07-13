return {
  "bloznelis/before.nvim",
  event = "VeryLazy",
  config = function()
    local before = require("before")
    before.setup()
  end,
  keys = {
    {
      "<C-S-O>",
      function()
        require("before").jump_to_last_edit()
      end,
      desc = "Jump to last edit",
    },
    {
      "<C-S-I>",
      function()
        require("before").jump_to_next_edit()
      end,
      desc = "Jump to next edit",
    },
    {
      "<leader>xe",
      function()
        require("before").show_edits_in_quickfix()
      end,
      desc = "Show edits in quickfix",
    },
    {
      "<leader>fe",
      function()
        require("before").show_edits_in_telescope()
      end,
      desc = "Edits",
    },
  },
}
