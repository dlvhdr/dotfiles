local status_ok, bufdelete = pcall(require, "bufdelete")
if not status_ok then
  return
end

vim.keymap.set("n", "<leader>q", function()
  print("wow")
  bufdelete.bufdelete(0, false)
end, { silent = true })
