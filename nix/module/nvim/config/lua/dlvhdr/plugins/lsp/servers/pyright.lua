local M = {}

M.setup = function(opts)
  local lspconfig = require("lspconfig")
  local util = require("lspconfig").util

  local venv_path = os.getenv("VIRTUAL_ENV")
  local py_path = nil
  if venv_path ~= nil then
    py_path = venv_path .. "/bin/python3"
  else
    py_path = vim.g.python3_host_prog
  end

  lspconfig.pyright.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    root_dir = util.root_pattern(".venv", "venv", "pyrightconfig.json"),
    on_init = function(client)
      client.config.settings.python.pythonPath = py_path
    end,
    settings = {
      python = {
        exclude = { ".venv" },
        venvPath = "./venv",
        venv = ".venv",
      },
    },
  })
end

return M
