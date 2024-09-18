local module = {}

module.traverseChildren = function(element, matchFn)
  if matchFn(element) then
    return element
  else
    local children = element:attributeValue('AXChildren')

    if children and #children > 0 then
      for _, child in ipairs(children) do
        local result = module.traverseChildren(child, matchFn)
        if result then
          return result
        end
      end
    end

    return nil
  end
end

module.searchByChain = function(startElement, fns, debugPrint)
  debugPrint = debugPrint or false
  local current = startElement

  for _, predicate in ipairs(fns) do
    current = module.traverseChildren(current, predicate)

    if debugPrint then
      p('Got: ' .. hs.inspect.inspect(current))
    end
    if not current then
      return nil
    end
  end

  return current
end

return module
