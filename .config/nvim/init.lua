vim.g.mapleader = " "
vim.g.do_filetype_lua = 1

pcall(require, "impatient")

require("dlvhdr.plugins")
require("dlvhdr.options")
require("dlvhdr.keymaps")
require("dlvhdr.autocmd")
