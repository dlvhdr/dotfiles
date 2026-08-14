return {
  "saecki/live-rename.nvim",
  keys = {
    {
      "gR",
      mode = "n",
      function()
        -- Start in insert mode and jump to the end of the word
        require("live-rename").rename({ cursorpos = -1 })
        -- put into append mode immediately, as insert-mode is placing cursor before
        vim.schedule(function()
          vim.api.nvim_feedkeys("A", "n", false)
        end)
      end,
      desc = "Rename",
    },
  },
}
