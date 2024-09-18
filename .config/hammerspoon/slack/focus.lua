local find = require('slack.find')
local debug = require('slack.debug')

----------

local function getAxSlackWindow()
  local app = hs.application.find('Slack')
  if not app then
    return
  end

  -- Electron apps require this attribute to be set or else you cannot
  -- read the accessibility tree
  axApp = hs.axuielement.applicationElement(app)
  axApp:setAttributeValue('AXManualAccessibility', true)

  local window = app:mainWindow()
  window:focus()

  return hs.axuielement.windowElement(window)
end

local function hasClass(element, class)
  local classList = element:attributeValue('AXDOMClassList')
  if not classList then
    return false
  end

  return hs.fnutils.contains(classList, class)
end

-----------

local module = {}

module.mainMessageBox = function()
  local window = getAxSlackWindow()
  if not window then
    return
  end

  local textarea = find.searchByChain(window, {
    function(elem)
      return hasClass(elem, 'p-workspace-layout')
    end,
    function(elem)
      return elem:attributeValue('AXSubrole') == 'AXLandmarkMain'
    end,
    function(elem)
      return hasClass(elem, 'p-workspace__primary_view_contents')
    end,
    function(elem)
      return hasClass(elem, 'c-wysiwyg_container')
    end,
    function(elem)
      return elem:attributeValue('AXRole') == 'AXTextArea'
    end,
  })

  if textarea then
    textarea:setAttributeValue('AXFocused', true)
  end
end

module.threadMessageBox = function(withRetry)
  withRetry = withRetry or false

  local window = getAxSlackWindow()
  if not window then
    return
  end

  local findTextarea = function()
    return find.searchByChain(window, {
      function(elem)
        return hasClass(elem, 'p-workspace-layout')
      end,
      function(elem)
        return hasClass(elem, 'p-flexpane')
      end,
      function(elem)
        return hasClass(elem, 'p-threads_flexpane')
      end,
      function(elem)
        return hasClass(elem, 'c-wysiwyg_container')
      end,
      function(elem)
        return elem:attributeValue('AXRole') == 'AXTextArea'
      end,
    })
  end

  local textarea = nil

  local textareaVisible = function()
    textarea = findTextarea()
    return not not textarea
  end

  local focusTextarea = function()
    textarea:setAttributeValue('AXFocused', true)
  end

  if withRetry then
    -- Do it in a retry loop
    local loopTimer = hs.timer.waitUntil(textareaVisible, focusTextarea)

    -- Give up after 2 seconds
    hs.timer.doAfter(2, function()
      loopTimer:stop()
    end)
  elseif textareaVisible() then
    -- fire it once
    focusTextarea()
  end
end

module.leaveChannel = function()
  local window = getAxSlackWindow()
  if not window then
    return
  end

  local button = find.searchByChain(window, {
    function(elem)
      return hasClass(elem, 'p-workspace-layout')
    end,
    function(elem)
      return elem:attributeValue('AXRole') == 'AXPopUpButton' and hasClass(elem, 'p-view_header__big_button--channel')
    end,
  })

  if not button then
    return
  end

  button:performAction('AXPress')

  leaveButton = nil

  local findLeaveButton = function()
    return find.searchByChain(window, {
      function(elem)
        return elem:attributeValue('AXSubrole') == 'AXApplicationDialog' and hasClass(elem, 'p-about_modal')
      end,
      function(elem)
        return elem:attributeValue('AXRole') == 'AXButton' and elem:attributeValue('AXTitle') == 'Leave channel'
      end,
    })
  end

  local leaveButtonVisible = function()
    leaveButton = findLeaveButton()
    return not not leaveButton
  end

  local buttonTimer = hs.timer.waitUntil(leaveButtonVisible, function()
    leaveButton:performAction('AXPress')
  end)

  hs.timer.doAfter(2, function()
    -- Prevent infinite spinning
    buttonTimer:stop()
  end)
end

return module
