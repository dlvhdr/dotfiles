vim.keymap.set("i", "t", require("dlvhdr.langs.javascript").add_async, { buffer = true })
vim.keymap.set("n", "<leader>k", require("dlvhdr.langs.javascript").goto_exported_symbol, { buffer = true })
