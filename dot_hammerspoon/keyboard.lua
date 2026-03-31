hs.alert.defaultStyle.strokeWidth = 0
hs.alert.defaultStyle.strokeColor = {red = 0, green = 0, blue = 0, alpha = 0.8}
hs.alert.defaultStyle.fillColor = {red = 0, green = 0, blue = 0, alpha = 0.8}
hs.alert.defaultStyle.radius = 12
hs.alert.defaultStyle.textSize = 14

-- Remap volume and mute keys to cmd+fn+f10/f11/f12 when Universal Audio is the output device
local function isUniversalAudioOutput()
  local device = hs.audiodevice.defaultOutputDevice()
  return device and device:name():find("Universal Audio") ~= nil
end

mediaKeyTap = hs.eventtap.new({hs.eventtap.event.types.systemDefined}, function(event)
  local data = event:systemKey()
  if not data or not data.down then return false end

  if not isUniversalAudioOutput() then return false end

  if data.key == "MUTE" then
    hs.eventtap.keyStroke({"cmd", "fn"}, "f10")
    return true
  elseif data.key == "SOUND_DOWN" then
    hs.eventtap.keyStroke({"cmd", "fn"}, "f11")
    return true
  elseif data.key == "SOUND_UP" then
    hs.eventtap.keyStroke({"cmd", "fn"}, "f12")
    return true
  end

  return false
end)
mediaKeyTap:start()

hs.hotkey.bind({"cmd"}, "f15", function()
  local current = hs.audiodevice.defaultOutputDevice()
  local targets = {"Universal Audio Thunderbolt", "HELIX Audio"}
  local next = targets[1]
  if current and current:name() == targets[1] then
    next = targets[2]
  end
  for _, device in ipairs(hs.audiodevice.allOutputDevices()) do
    if device:name() == next then
      device:setDefaultOutputDevice()
      hs.alert.show("🔈 Output: " .. next)
      return
    end
  end
end)

hs.hotkey.bind({}, "f18", function()
  local zoom = hs.application.get("zoom.us")
  local meetingWin = zoom and zoom:findWindow("Zoom Meeting")
  if meetingWin then
    hs.eventtap.keyStroke({"cmd", "shift"}, "a")
  elseif hs.application.get("Tuple") and #hs.application.get("Tuple"):visibleWindows() > 0 then
    hs.eventtap.keyStroke({"cmd", "ctrl"}, "a")
  end
end)

hs.hotkey.bind({}, "f19", function()
  local zoom = hs.application.get("zoom.us")
  local meetingWin = zoom and zoom:findWindow("Zoom Meeting")
  if meetingWin then
    meetingWin:focus()
    hs.osascript.applescript([[
      tell application "System Events"
      tell process "zoom.us"
          keystroke "w" using {command down}
          delay 0.5
          key code 36
      end tell
    end tell
  ]])
  elseif hs.application.get("Tuple") and #hs.application.get("Tuple"):visibleWindows() > 0 then
    local tuple = hs.application.get("Tuple")
    tuple:activate()
    hs.timer.doAfter(0.5, function()
      hs.eventtap.keyStroke({"cmd", "ctrl"}, "q")
    end)
  end
end)

hs.hotkey.bind({"ctrl", "alt"}, "home", function()
  hs.execute("open -a ScreenSaverEngine")
end)

hs.hotkey.bind({"ctrl", "alt"}, "end", function()
  hs.caffeinate.systemSleep()
end)
