vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.do_filetype_lua = 1
vim.g.vim_json_conceal = false
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("dlvhdr.lazy")
require("dlvhdr.options")
require("dlvhdr.keymaps")
require("dlvhdr.autocmd")
