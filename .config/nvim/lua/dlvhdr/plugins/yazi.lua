return {
  "DreamMaoMao/yazi.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  cmd = "Yazi",
  keys = {
    -- { "<leader>fe", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
    { "<leader>e", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
  },
  init = function()
    local function open_yazi(data)
      -- buffer is a directory
      local directory = vim.fn.isdirectory(data.file) == 1

      if not directory then
        return
      end

      -- change to the directory
      vim.cmd.cd(data.file)

      -- open the tree
      vim.cmd("Yazi")
    end

    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_yazi })
  end,
}
