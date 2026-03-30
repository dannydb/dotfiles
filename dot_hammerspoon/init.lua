require("hs.ipc")
require("desk-lamp")
require("camera-lights")
require("audio-devices")
require("mouse-battery")
require("keyboard")
require("windows")


hs.urlevent.bind("codelayout", function()
  codeLayout()
end)

hs.urlevent.bind("guitarlayout", function()
  guitarLayout()
end)