require("persistence").setup({})
local bufdelete = require("bufdelete")

local group = vim.api.nvim_create_augroup("SessionPreventSavingNvimTree", { clear = true })
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if vim.api.nvim_buf_get_name(0) == "NvimTree" then
      bufdelete(0, true)
    end
  end,
  group = group,
})
