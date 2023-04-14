local uv = vim.loop

local M = {}
function M.read_file(path)
  local fd = uv.fs_open(path, "r", 438)
  local stat = uv.fs_fstat(fd)
  local text = uv.fs_read(fd, stat.size, 0)
  uv.fs_close(fd)

  return text
end

function M.read_json(path)
  return vim.fn.json_decode(M.read_file(path))
end

function M.toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
end

return M
