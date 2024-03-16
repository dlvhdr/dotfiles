return {
  "bloznelis/before.nvim",
  config = function()
    local before = require("before")
    before.setup()
  end,
  keys = {
    {
      "<C-H>",
      function()
        require("before").jump_to_last_edit()
      end,
      { desc = "Jump to last edit" },
    },
    {
      "<C-L>",
      function()
        require("before").jump_to_next_edit()
      end,
      { desc = "Jump to next edit" },
    },
    {
      "<leader>xe",
      function()
        require("before").show_edits_in_quickfix()
      end,
      { desc = "Show edits in quickfix" },
    },
    {
      "<leader>fe",
      function()
        require("before").show_edits_in_telescope()
      end,
      { desc = "Show edits in telescope" },
    },
  },
}
