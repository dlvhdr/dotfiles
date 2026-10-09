return {
  "mrjones2014/smart-splits.nvim",
  build = "./kitty/install-kittens.bash",
  lazy = false,
  init = function()
    vim.keymap.set("n", "<C-S-h>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<C-S-j>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<C-S-k>", require("smart-splits").resize_up)
    vim.keymap.set("n", "<C-S-l>", require("smart-splits").resize_right)
    -- moving between splits
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
    vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
    -- swapping buffers between windows
    vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
    vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
    vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
    vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
  end,
}
