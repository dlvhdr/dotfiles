local M = {}

local lsp_signature = require("lsp_signature")

M.setup = function(bufnr)
  lsp_signature.on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "single",
    },
    floating_window = false,
    hi_parameter = "Search",
    max_width = 60,
    max_height = 12,
    hint_prefix = " ",
    doc_lines = 0,
  }, bufnr)
end

return M
