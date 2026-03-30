hs.window.animationDuration = 0

local mods = {"ctrl", "alt"}
local modsShift = {"ctrl", "alt", "shift"}
local modsCmd = {"ctrl", "alt", "cmd"}

local cycleSizes = {0.5, 2/3, 1/3}
local cycleState = {}

local TOLERANCE = 10

local function approxEqual(a, b)
  return math.abs(a - b) < TOLERANCE
end

local function matchesPosition(win, screen, x, y, w, h)
  local f = win:frame()
  return approxEqual(f.x, screen.x + x * screen.w)
    and approxEqual(f.y, screen.y + y * screen.h)
    and approxEqual(f.h, h * screen.h)
end

local function cycleSizeForDirection(win, direction, xFn, y, h)
  local screen = win:screen():frame()
  local key = win:id() .. direction

  for i, size in ipairs(cycleSizes) do
    if matchesPosition(win, screen, xFn(size), y, size, h)
       or matchesPosition(win, screen, xFn(size), y, h, size) then
      local next = (i % #cycleSizes) + 1
      cycleState[key] = next
      return cycleSizes[next]
    end
  end

  cycleState[key] = 1
  return cycleSizes[1]
end

local function move(win, x, y, w, h)
  local screen = win:screen():frame()
  win:setFrame({
    x = screen.x + (x * screen.w),
    y = screen.y + (y * screen.h),
    w = w * screen.w,
    h = h * screen.h,
  })
end

local function resizeBy(factor)
  local win = hs.window.focusedWindow()
  if not win then return end
  local f = win:frame()
  local screen = win:screen():frame()
  local dw = screen.w * 0.05 * factor
  local dh = screen.h * 0.05 * factor
  win:setFrame({
    x = f.x - dw / 2,
    y = f.y - dh / 2,
    w = f.w + dw,
    h = f.h + dh,
  })
end

-- Halves with cycling (½, ⅔, ⅓)
hs.hotkey.bind(mods, "left", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local w = cycleSizeForDirection(win, "left", function() return 0 end, 0, 1)
  move(win, 0, 0, w, 1)
end)

hs.hotkey.bind(mods, "right", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local w = cycleSizeForDirection(win, "right", function(s) return 1 - s end, 0, 1)
  move(win, 1 - w, 0, w, 1)
end)

hs.hotkey.bind(mods, "up", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local h = cycleSizeForDirection(win, "up", function() return 0 end, 0, 1)
  move(win, 0, 0, 1, h)
end)

hs.hotkey.bind(mods, "down", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local h = cycleSizeForDirection(win, "down", function() return 0 end, 0, 1)
  move(win, 0, 1 - h, 1, h)
end)

-- Quarters
hs.hotkey.bind(mods, "u", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  move(win, 0, 0, 0.5, 0.5)
end)

hs.hotkey.bind(mods, "i", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  move(win, 0.5, 0, 0.5, 0.5)
end)

hs.hotkey.bind(mods, "j", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  move(win, 0, 0.5, 0.5, 0.5)
end)

hs.hotkey.bind(mods, "k", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  move(win, 0.5, 0.5, 0.5, 0.5)
end)

-- Center Third
hs.hotkey.bind(mods, "f", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  move(win, 1/3, 0, 1/3, 1)
end)

-- Maximize
hs.hotkey.bind(mods, "return", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  move(win, 0, 0, 1, 1)
end)

-- Maximize Height
hs.hotkey.bind(modsShift, "up", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local f = win:frame()
  local screen = win:screen():frame()
  win:setFrame({
    x = f.x,
    y = screen.y,
    w = f.w,
    h = screen.h,
  })
end)

-- Make Larger / Smaller
hs.hotkey.bind(mods, "=", function() resizeBy(1) end)
hs.hotkey.bind(mods, "-", function() resizeBy(-1) end)

-- Restore
local previousFrames = {}

local originalMove = move
move = function(win, x, y, w, h)
  previousFrames[win:id()] = win:frame()
  originalMove(win, x, y, w, h)
end

hs.hotkey.bind(mods, "delete", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local prev = previousFrames[win:id()]
  if prev then
    win:setFrame(prev)
    previousFrames[win:id()] = nil
  end
end)

-- Next / Previous Display
hs.hotkey.bind(modsCmd, "right", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  win:moveToScreen(win:screen():next(), true, true)
end)

hs.hotkey.bind(modsCmd, "left", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  win:moveToScreen(win:screen():previous(), true, true)
end)

function guitarLayout()
  hs.layout.apply({
    { "HX Edit",    nil, screen, {0, 0, 0.5, 0.5},  nil, nil },
    { "Capo",  nil, screen, {0, 0.5, 0.5, 0.5}, nil, nil },
    { "forScore",   nil, screen, hs.layout.right50, nil, nil },
  })
end

function codeLayout()
  hs.layout.apply({
    { "Code",    nil, screen, hs.layout.left50, nil, nil },
    { "Arc",   nil, screen, hs.layout.right50, nil, nil },
  })
end