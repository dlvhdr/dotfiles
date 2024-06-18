return {
  "echasnovski/mini.files",
  version = "*",
  keys = {
    {
      "<leader>e",
      function()
        local MiniFiles = require("mini.files")
        if not MiniFiles.close() then
          MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        end
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

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesWindowUpdate",
      callback = function(args)
        vim.wo[args.data.win_id].number = true
        vim.wo[args.data.win_id].relativenumber = true
      end,
    })
  end,
  config = function()
    require("mini.files").setup({
      windows = {
        preview = false,
      },
      mappings = {
        synchronize = "<leader>bw",
      },
      use_as_default_explorer = true,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionRename",
      callback = function(event)
        require("dlvhdr.plugins.lsp.handlers").on_rename(event.data.from, event.data.to)
      end,
    })

    local theme = require("dlvhdr.plugins.theme")
    local colors = theme.colors()
    if colors then
      vim.api.nvim_set_hl(0, "MiniFilesDirectory", { fg = colors.blue })
    end
  end,
}
