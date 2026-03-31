require("hs.ipc")
require("desk-lamp")
require("meeting")
require("mouse-battery")
require("keyboard")
require("windows")


hs.urlevent.bind("codelayout", function()
  codeLayout()
end)

hs.urlevent.bind("guitarlayout", function()
  guitarLayout()
end)