local function hasStudioDisplay()
  for _, screen in ipairs(hs.screen.allScreens()) do
    if screen:name() == "Studio Display" then return true end
  end
  return false
end

local function deskLamp(on)
  if hasStudioDisplay() then
    hs.shortcuts.run(on and "Desk Lamp On" or "Desk Lamp Off")
  end
end

hs.screen.watcher.new(function()
  deskLamp(hasStudioDisplay())
end):start()

hs.caffeinate.watcher.new(function(event)
  if event == hs.caffeinate.watcher.systemWillSleep then
    deskLamp(false)
  elseif event == hs.caffeinate.watcher.systemDidWake then
    deskLamp(true)
  end
end):start()
