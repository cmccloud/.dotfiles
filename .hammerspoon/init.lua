--------------------------------------------------------
-- initialization
--------------------------------------------------------

local hyper = {"cmd", "ctrl"}
local buffer = 5
hs.window.animationDuration = 0
--------------------------------------------------------
-- Window Management
--------------------------------------------------------
function toggleBuffer ()
  if buffer == 5 then
    buffer = 0
  else
    buffer = 5
  end
  hs.alert.show("Window buffer toggled")
end

hs.hotkey.bind(hyper, "o", toggleBuffer)
--------------------------------------------------------
-- hyper j = left one half window
--------------------------------------------------------
function leftHalf ()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + buffer
  f.y = max.y + buffer
  f.w = max.w / 2 - (buffer * 2)
  f.h = max.h - (buffer * 5)
  win:setFrame(f)
end

hs.hotkey.bind(hyper, "j", leftHalf)
--------------------------------------------------------
-- hyper k = right one half window
--------------------------------------------------------
function rightHalf ()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2) + buffer
  f.y = max.y + buffer
  f.w = max.w / 2 - (buffer * 2)
  f.h = max.h - (buffer * 5)
  win:setFrame(f)
end
hs.hotkey.bind(hyper, "k", rightHalf)
--------------------------------------------------------
-- hyper enter = full screen
--------------------------------------------------------
function fullscreen ()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + buffer
  f.y = max.y + buffer
  f.w = max.w - (buffer * 2)
  f.h = max.h - (buffer * 5)
  win:setFrame(f)
end
hs.hotkey.bind(hyper, "return", fullscreen)

--------------------------------------------------------
-- Reload on config change
--------------------------------------------------------
function reloadConfig (files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Reloaded Hammerspoon Configuration File")


