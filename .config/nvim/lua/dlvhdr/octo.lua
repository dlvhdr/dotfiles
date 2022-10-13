local status_ok, octo = pcall(require, "octo")
if not status_ok then
  return
end

local parsers_ok, parsers = pcall(require, "nvim-treesitter.parsers")
if not parsers_ok then
  return
end

require("dlvhdr.theme")
octo.setup()
