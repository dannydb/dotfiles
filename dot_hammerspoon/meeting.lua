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

local function switchAudioSource(typeFlag, name)
  hs.execute(string.format('/opt/homebrew/bin/SwitchAudioSource -t %s -s "%s"', typeFlag, name))
end

-- Camera watcher
studioDisplayCamera = nil
for _, c in ipairs(hs.camera.allCameras()) do
  if c:name() == "Studio Display Camera" then
    studioDisplayCamera = c
    break
  end
end

if studioDisplayCamera then
  studioDisplayCamera:setPropertyWatcherCallback(function(cam)
    if cam:isInUse() and hasUniversalAudio() then
      hs.shortcuts.run("Turn on meeting lights")
    elseif not isAirPodsConnected() then
      hs.shortcuts.run("Turn off meeting lights")
    end
  end)
  studioDisplayCamera:startPropertyWatcher()
end

-- Audio device watcher
local previouslyConnected = isAirPodsConnected()

local function audioDeviceCallback(event)
  if event ~= "dev#" then return end

  local connected = isAirPodsConnected()

  if connected and not previouslyConnected then
    switchAudioSource("input", "Universal Audio Thunderbolt")
    switchAudioSource("output", "Danny’s AirPods Pro")
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
