local function isWebcamActive()
  for _, cam in ipairs(hs.camera.allCameras()) do
    if cam:isInUse() then return true end
  end
  return false
end

local function isAirPodsConnected()
  for _, device in ipairs(hs.audiodevice.allOutputDevices()) do
    if device:name() == "Danny’s AirPods Pro" then return true end
  end
  return false
end

local function hasUniversalAudio()
  for _, device in ipairs(hs.audiodevice.allInputDevices()) do
    if device:name():find("Universal Audio") then return true end
  end
  return false
end

local function setDefaultDevice(name, findFn, setFn)
  for _, device in ipairs(findFn()) do
    if device:name() == name then
      device[setFn](device)
      return
    end
  end
end

-- Camera watcher
studioDisplayCamera = nil
for _, c in ipairs(hs.camera.allCameras()) do
  if c:name() == "Studio Display Camera" then
    studioDisplayCamera = c
    break
  end
end

lightsOffTimer = nil

if studioDisplayCamera then
  studioDisplayCamera:setPropertyWatcherCallback(function(cam)
    if cam:isInUse() and hasUniversalAudio() then
      if lightsOffTimer then lightsOffTimer:stop() end
      hs.shortcuts.run("Turn on meeting lights")
    elseif not isAirPodsConnected() then
      if lightsOffTimer then lightsOffTimer:stop() end
      lightsOffTimer = hs.timer.doAfter(5, function()
        if not cam:isInUse() then
          hs.shortcuts.run("Turn off meeting lights")
        end
      end)
    end
  end)
  studioDisplayCamera:startPropertyWatcher()
end

-- Audio device watcher
local previouslyConnected = isAirPodsConnected()

local function audioDeviceCallback(event)
  if event == "dIn " then
    if isAirPodsConnected() and hasUniversalAudio()
        and hs.audiodevice.defaultInputDevice():name() == "Danny’s AirPods Pro" then
      setDefaultDevice("Universal Audio Thunderbolt", hs.audiodevice.allInputDevices, "setDefaultInputDevice")
    end
    return
  end
  if event ~= "dev#" then return end

  local connected = isAirPodsConnected()

  if connected and not previouslyConnected then
    setDefaultDevice("Universal Audio Thunderbolt", hs.audiodevice.allInputDevices, "setDefaultInputDevice")
    setDefaultDevice("Danny’s AirPods Pro", hs.audiodevice.allOutputDevices, "setDefaultOutputDevice")
    if hasUniversalAudio() then
      hs.shortcuts.run("Turn on meeting lights")
    end
  elseif not connected and previouslyConnected then
    if not isWebcamActive() then
      hs.shortcuts.run("Turn off meeting lights")
    end
  end

  previouslyConnected = connected
end

hs.audiodevice.watcher.setCallback(audioDeviceCallback)
hs.audiodevice.watcher.start()
