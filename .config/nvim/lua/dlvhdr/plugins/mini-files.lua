return {
  "echasnovski/mini.files",
  version = "*",
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
      end,
      desc = "Files",
    },
  },
  init = function()
    local function open_files(data)
      local directory = vim.fn.isdirectory(data.file) == 1

      if not directory then
        return
      end

      -- change to the directory
      vim.cmd.cd(data.file)

      -- open the tree
      require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
    end
    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_files })
  end,
}
