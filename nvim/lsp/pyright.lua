return {
  root_markers = { ".venv", "venv", "pyrightconfig.json" },
  on_init = function(client)
    local venv_path = os.getenv("VIRTUAL_ENV")
    local py_path = nil
    if venv_path ~= nil then
      py_path = venv_path .. "/bin/python3"
    else
      py_path = vim.g.python3_host_prog
    end
    client.config.settings.python.pythonPath = py_path
  end,
  settings = {
    python = {
      exclude = { ".venv" },
      venvPath = "./venv",
      venv = ".venv",
    },
  },
}
