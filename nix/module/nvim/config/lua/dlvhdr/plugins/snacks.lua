return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      sections = {
        {
          section = "terminal",
          cmd = "artprint --random -t dlvhdr --tc 5 --ac 4",
          padding = 0,
          align = "center",
          height = 30,
          width = 60,
          ttl = 86400,
          gap = 2,
        },
        { section = "startup", align = "center", padding = 2 },
        {
          icon = " ",
          desc = "Last Session",
          padding = 1,
          key = "s",
          action = "<cmd>silent lua require('persistence').load()<CR>",
          pane = 2,
        },
        {
          icon = "󰛢 ",
          desc = "Grapple",
          padding = 1,
          key = "m",
          action = "<CMD>Grapple open_tags<CR>",
          pane = 2,
        },
        {
          icon = " ",
          desc = "New file",
          padding = 1,
          key = "e",
          action = "<CMD>ene <BAR> startinsert<CR>",
          pane = 2,
        },
        {
          icon = "󰅚 ",
          desc = "Quit",
          padding = 1,
          key = "q",
          action = "<CMD>qa<CR>",
          pane = 2,
        },
      },
    },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    bufdelete = { enabled = true },
    scratch = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
  },
}
-- want:
-- dashboard
