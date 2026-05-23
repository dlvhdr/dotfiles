return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>c*",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>"), paths = vim.fn.expand("%") } })
      end,
      desc = "Find and replace in current word in current buffer",
      mode = { "n", "x" },
      silent = true,
    },
    {
      "<leader>cr",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      desc = "Find and replace in current buffer",
      mode = { "n", "x" },
      silent = true,
    },
    {
      "<leader>cR",
      function()
        require("grug-far").open()
      end,
      desc = "Find and replace globally",
      mode = { "n", "x" },
      silent = true,
    },
  },
  config = function()
    require("grug-far").setup({
      resultsSeparatorLineChar = "―",
      openTargetWindow = {
        preferredLocation = "right",
      },
    })
  end,
}
