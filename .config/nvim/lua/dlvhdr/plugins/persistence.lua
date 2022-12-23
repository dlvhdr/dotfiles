return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  config = function()
    local status_ok, persistence = pcall(require, "persistence")
    if not status_ok then
      return
    end

    persistence.setup({})

    local group = vim.api.nvim_create_augroup("SessionPreventSavingNvimTree", { clear = true })
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        if vim.api.nvim_buf_get_name(0) == "NvimTree" then
          local bufdelete = require("bufdelete")
          bufdelete(0, true)
        end
      end,
      group = group,
    })
  end,
}
