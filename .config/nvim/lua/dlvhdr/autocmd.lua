-- Highlighted Yank
vim.cmd([[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="Visual", timeout=100}
  augroup END
]])

-- Lighbulb in gutter for lsp code actions
vim.cmd([[
  autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
]])

vim.fn.sign_define("LightBulbSign", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })

vim.cmd("language en_US.utf-8")

vim.cmd("autocmd User LspProgressUpdate redrawstatus")
vim.cmd("autocmd User LspRequest redrawstatus")
