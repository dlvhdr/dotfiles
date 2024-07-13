return {
  {
    "nvim-treesitter/nvim-treesitter",
    ft = { "markdown", "mdx" },
    config = function()
      local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
      ft_to_parser["mdx"] = "markdown"
    end,
  },
  {
    "tadmccorkle/markdown.nvim",
    ft = { "markdown", "mdx" },
    opts = {},
    config = function(opts)
      require("markdown").setup(opts)

      -- In visual mode, surround the selected text with markdown link syntax
      vim.keymap.set("v", "<leader>ml", function()
        -- delete selected text
        vim.cmd("normal d")
        -- Insert the following in insert mode
        vim.cmd("startinsert")
        vim.api.nvim_put({ "[]() " }, "c", true, true)
        -- Move to the left, paste, and then move to the right
        vim.cmd("normal F[pf)")
        -- vim.cmd("normal 2hpF[l")
        -- Leave me in insert mode to start typing
        vim.cmd("startinsert")
      end, { desc = "Convert to Link" })

      -- In visual mode, check if the selected text is already bold and show a message if it is
      -- If not, surround it with double asterisks for bold
      vim.keymap.set("v", "<leader>mb", function()
        -- Get the selected text range
        local start_row, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
        local end_row, end_col = unpack(vim.fn.getpos("'>"), 2, 3)
        -- Get the selected lines
        local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
        local selected_text = table.concat(lines, "\n"):sub(start_col, #lines == 1 and end_col or -1)
        if selected_text:match("^%*%*.*%*%*$") then
          vim.notify("Text already bold", vim.log.levels.INFO)
        else
          vim.cmd("normal 2sa*")
        end
      end, { desc = "Bold Current Selection" })
    end,
  },
}
