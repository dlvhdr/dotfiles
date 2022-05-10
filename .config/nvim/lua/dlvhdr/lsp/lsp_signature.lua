local M = {}

local lsp_signature = require("lsp_signature")

M.setup = function(bufnr)
  lsp_signature.on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded",
    },
    floating_window_above_cur_line = false,
    hint_prefix = " ",
  }, bufnr)
end

return M
