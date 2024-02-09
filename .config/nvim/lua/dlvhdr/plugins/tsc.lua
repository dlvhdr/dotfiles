return {
  "dmmulroy/tsc.nvim",
  cmd = "TSC",
  config = function()
    require("tsc").setup({
      enable_progress_notifications = true,
      auto_open_qflist = true,
    })

    -- Replace the quickfix window with Trouble when viewing TSC results
    local function replace_quickfix_with_trouble()
      local qflist = vim.fn.getqflist({ title = 0, items = 0 })

      if qflist.title ~= "TSC" then
        return
      end

      local ok, trouble = pcall(require, "trouble")

      if ok then
        -- close trouble if there are no more items in the quickfix list
        if next(qflist.items) == nil then
          vim.defer_fn(trouble.close, 0)
          return
        end

        vim.defer_fn(function()
          vim.cmd("cclose")
          trouble.open("quickfix")
        end, 0)
      end
    end

    local group = vim.api.nvim_create_augroup("ReplaceQuickfixWithTrouble", {})
    vim.api.nvim_create_autocmd("BufWinEnter", {
      pattern = "quickfix",
      group = group,
      callback = replace_quickfix_with_trouble,
    })
  end,
}
