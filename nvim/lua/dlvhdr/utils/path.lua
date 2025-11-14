local M = {}

M.relative_to = function(from, to)
  print("from", from, "to", to)
  local min_len = math.min(to:len(), from:len())
  local mismatch = 0

  for i = 1, min_len do
    if to:sub(i, i) ~= from:sub(i, i) then
      mismatch = i
      break
    end
  end

  local to_diff = to:sub(mismatch)
  local from_diff = from:sub(mismatch)

  local from_is_dir = false

  local result = ""
  for _ in from_diff:gmatch("/") do
    result = result .. "../"
  end
  if from_is_dir then
    result = result .. "../"
  end
  result = result .. to_diff

  return result
end

M.wow = function(from, to)
  local min_len = math.min(to:len(), from:len())
  local mismatch = 0

  for i = 1, min_len do
    if to:sub(i, i) ~= from:sub(i, i) then
      mismatch = i
      break
    end
  end

  -- handle edge cases here

  -- the parts of `a` and `b` that differ
  local to_diff = to:sub(mismatch)
  local from_diff = from:sub(mismatch)

  local from_file = io.open(from)
  local from_is_dir = false
  if from_file then
    -- check if `from` is a directory
    local result, err_msg, err_no = from_file:read(0)
    if err_no == 21 then -- EISDIR - `from` is a directory
    end
  end

  local result = ""
  for _ in from_diff:gmatch("/") do
    result = result .. "../"
  end
  if from_is_dir then
    result = result .. "../"
  end
  return result .. to_diff
end

return M
