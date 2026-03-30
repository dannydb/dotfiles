hs.hotkey.bind({}, "f16", function()
  hs.eventtap.keyStroke({"cmd", "fn"}, "f11")
end)

hs.hotkey.bind({}, "f17", function()
  hs.eventtap.keyStroke({"cmd", "fn"}, "f12")
end)

hs.hotkey.bind({}, "f18", function()
  hs.eventtap.keyStroke({"cmd", "fn"}, "f18")
end)

hs.hotkey.bind({}, "f19", function()
  hs.osascript.applescript([[
    tell application "zoom.us"
      activate
      tell application "System Events"
        keystroke "w" using {command down}
      end tell
      tell application "System Events"
        tell front window of (first application process whose frontmost is true)
          click button 1
        end tell
      end tell
    end tell
  ]])
end)
