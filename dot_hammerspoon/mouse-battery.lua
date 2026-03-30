local function sleepWatcherCallback(event)
  if event == hs.caffeinate.watcher.systemWillSleep then
    hs.shortcuts.run("Check mouse battery")
  end
end

mouseBatteryCaffeinateWatcher = hs.caffeinate.watcher.new(sleepWatcherCallback)
mouseBatteryCaffeinateWatcher:start()
