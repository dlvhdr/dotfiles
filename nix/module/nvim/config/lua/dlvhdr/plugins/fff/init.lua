return {
  {
    "dmtrKovalenko/fff.nvim",
    build = "cargo build --release",
    dependencies = { "folke/snacks.nvim" },
    lazy = false,
    keys = {
      {
        "<C-p>",
        function()
          require("dlvhdr.plugins.fff.fff").fff()
        end,
        desc = "Project Files",
      },
    },
    opts = {
      prompt = "",
      keymaps = {
        move_up = { "<Up>", "<C-p>", "<C-k>" },
        move_down = { "<Down>", "<C-n>", "<C-j>" },
      },
      layout = {
        prompt_position = "top",
      },
    },
  },
}
