vim.g.mapleader = " "
vim.g.do_filetype_lua = 1
vim.g.vim_json_conceal = false
vim.g.indentLine_concealcursor = "nc"

pcall(require, "impatient")

require("dlvhdr.plugins")
require("dlvhdr.options")
require("dlvhdr.keymaps")
require("dlvhdr.autocmd")
