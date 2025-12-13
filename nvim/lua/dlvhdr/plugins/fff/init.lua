return {
  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      -- this will download prebuild binary or try to use existing rustup toolchain to build from source
      -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
      require("fff.download").download_or_build_binary()
    end,
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
      layout = { preset = "select", prompt_position = "top" },
      live = true,
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
          truncate = 80, -- truncate the file path to (roughly) this length
          filename_only = false, -- only show the filename
          icon_width = 2, -- width of the icon (in characters)
          git_status_hl = true, -- use the git status highlight group for the filename
        },
      },
      preview = "none",
    },
  },
}
