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

function M.dir_has_file(path, name)
  if not lsputil_ok then
    return false
  end

  return lsputil.path.exists(lsputil.path.join(path, name))
end

return M
