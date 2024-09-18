local module = {}

module.printElement = function(element)
  if not element then
    p('Element is nil')
    return
  end

  p(element:attributeValue('AXRole'))
  p('  AXSubrole:         ' .. tostring(element:attributeValue('AXSubrole')))
  p('  AXDescription:     ' .. tostring(element:attributeValue('AXDescription')))
  p('  AXRoleDescription: ' .. tostring(element:attributeValue('AXRoleDescription')))
  p('  AXAccessKey:       ' .. tostring(element:attributeValue('AXAccessKey')))
  p('  AXDOMIdentifier:   ' .. tostring(element:attributeValue('AXDOMIdentifier')))
  p('  AXDOMClassList:    ' .. hs.inspect.inspect(element:attributeValue('AXDOMClassList')))
  p('  Attribute keys:    ' .. hs.inspect.inspect(element:attributeNames()))
  p('  Actions:           ' .. hs.inspect.inspect(element:actionNames()))
end

module.printPath = function(path)
  p('Got path')
  p('---------------')
  p('')

  for i, element in ipairs(path) do
    module.printElement(element)
    p('')
    p('---------------')
    p('')
  end
end

module.findAxTextArea = function(element, path)
  path = path or {}
  path = hs.fnutils.copy(path)
  table.insert(path, element)

  if element:attributeValue('AXRole') == 'AXTextArea' then
    module.printPath(path)
    return
  else
    local children = element:attributeValue('AXChildren')

    if children and #children > 0 then
      hs.fnutils.each(children, function(child)
        module.findAxTextArea(child, path)
      end)
    end
  end
end

module.findTextAreaPaths = function()
  local app = hs.application.find('Slack')
  if not app then
    return
  end

  local ax = hs.axuielement.applicationElement(app)
  module.searchChildren(ax)
end

return module
