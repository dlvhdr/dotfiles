vim.g.mapleader = " "
vim.g.do_filetype_lua = 1

local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok and impatient ~= nil then
  impatient.enable_profile()
end

require("dlvhdr.plugins")
require("dlvhdr.options")
require("dlvhdr.keymaps")
require("dlvhdr.autocmd")
