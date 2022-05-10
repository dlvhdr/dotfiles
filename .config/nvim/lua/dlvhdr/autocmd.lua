-- Highlighted Yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  command = "silent! lua require('nvim-lightbulb').update_lightbulb() end"
})

vim.fn.sign_define("LightBulbSign", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })

vim.cmd("language en_US.utf-8")

vim.cmd("autocmd User LspProgressUpdate redrawstatus")
vim.cmd("autocmd User LspRequest redrawstatus")

-- Make these commonly mistyped commands still work
vim.cmd("command! WQ wq")
vim.cmd("command! Wq wq")
vim.cmd("command! Wqa wqa")
vim.cmd("command! W w")
vim.cmd("command! Q q")
