local M = {}

function M.get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv from poetry in workspace directory.
  local match = vim.fn.glob(path.join(workspace, "pyproject.toml"))
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
    return path.join(venv, "bin", "python")
  end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python3"
end

M.setup = function(opts)
  local lspconfig = require("lspconfig")
  local util = require("lspconfig").util

  local venv_path = os.getenv("VIRTUAL_ENV")
  local py_path = nil
  -- decide which python executable to use for mypy
  vim.notify("venv_path: " .. venv_path)
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
