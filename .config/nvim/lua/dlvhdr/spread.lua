local status_ok, spread = pcall(require, "spread")
if not status_ok then
  return
end

local default_options = { silent = true, noremap = true }

vim.keymap.set("n", "gS", spread.out, default_options)
vim.keymap.set("n", "gJ", spread.combine, default_options)
