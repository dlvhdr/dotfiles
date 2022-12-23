local status_ok, bufdelete = pcall(require, "bufdelete")
if not status_ok then
  return
end

vim.keymap.set("n", "<leader>q", function()
  bufdelete.bufdelete(0, false)
end, { silent = true })
