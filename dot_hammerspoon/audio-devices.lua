local previouslyConnected = false

for _, device in ipairs(hs.audiodevice.allOutputDevices()) do
  if device:name() == "Danny’s AirPods Pro" then
    previouslyConnected = true
    break
  end
end

local function audioDeviceCallback(event)
  if event ~= "dev#" then return end

  local connected = false
  for _, device in ipairs(hs.audiodevice.allOutputDevices()) do
    if device:name() == "Danny’s AirPods Pro" then
      connected = true
      break
    end
  end

  if connected and not previouslyConnected then
    hs.shortcuts.run("Conference Audio")
  elseif not connected and previouslyConnected then
    hs.shortcuts.run("Turn off meeting lights")
  end

  previouslyConnected = connected
end

hs.audiodevice.watcher.setCallback(audioDeviceCallback)
hs.audiodevice.watcher.start()
