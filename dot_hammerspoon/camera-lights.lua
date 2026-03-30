local camera
for _, c in ipairs(hs.camera.allCameras()) do
  if c:name() == "Studio Display Camera" then
    camera = c
    break
  end
end

if camera then
  camera:setPropertyWatcherCallback(function(cam)
    if cam:isInUse() then
      hs.shortcuts.run("Turn on meeting lights")
    else
      hs.shortcuts.run("Turn off meeting lights")
    end
  end)
  camera:startPropertyWatcher()
end
