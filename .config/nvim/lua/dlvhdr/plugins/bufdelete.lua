return {
  "famiu/bufdelete.nvim",
  init = function()
    vim.keymap.set("n", "<leader>q", function()
      require("bufdelete").bufdelete(0, false)
    end, { silent = true, desc = "Quit Buffer" })
  end,
}
