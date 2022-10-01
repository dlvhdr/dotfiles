require("nvim-lightbulb").setup({ autocmd = { enabled = true } })

vim.fn.sign_define("LightBulbSign", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
