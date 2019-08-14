myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded 👍", 3)

modkey = {"cmd","alt"}

-- {'⌘', '⌥', 'ctrl'}
hyper = {'ctrl', 'alt', 'cmd'}

--{'⌘', '⌥', '⇧', 'ctrl'}
hyperShift = {'ctrl', 'shift'}

--
-- [[ Functions ]] --
--

-- Reload on config change
function reloadConfig(files)
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

-- open key folders with ctrl + key
function directoryLaunchKeyRemap(mods, key, dir)
    local mods = mods or {}
    hs.hotkey.bind(mods, key, function()
        local shell_command = "open " .. dir
        hs.execute(shell_command)
    end)
end

hs.hotkey.bind({"ctrl"}, 'F', function()
      finder = hs.appfinder.appFromName("Finder")
      finder:selectMenuItem({"File","New Finder Window"})
      finder:activate()
      end)


hs.hotkey.bind({"alt"}, 'p', function()
    hs.itunes.pause()
      end)

hs.hotkey.bind({"alt", "shift"}, 'P', function()
    hs.itunes.play()
      end)
      
      --- quick open folders
directoryLaunchKeyRemap({"ctrl"}, "D", "~/Documents") 

hs.hotkey.bind({"ctrl"}, "R", function()
  subl = hs.appfinder.appFromName("Sublime Text")
  subl:selectMenuItem({"File", "New Window"})
  subl:activate()
  end)

-- raise console
hs.hotkey.bind({"cmd", "alt"}, "Y", hs.toggleConsole)

--- key macros
   function keyStrokes(str)
     return function()
         hs.eventtap.keyStrokes(str)
     end
   end

  hs.hotkey.bind({"alt", "cmd"}, "L", keyStrokes("http://pilot.muse.jhu.edu/collection/collection.cgi"))
  
  hs.hotkey.bind({"cmd", "alt"},"0",function()
  local proofingLayout = {
    {"Acrobat", nil, nil, hs.layout.right50, nil, nil},
   }
    hs.layout.apply(proofingLayout)

  aacrobat = hs.appfinder.appFromName("Acrobat")
  aacrobat:selectMenuItem({"View","Zoom", "Zoom to Page Level"})
  aacrobat:activate()
end)

-- TILING --
local tiling = require "hs.tiling"
local hotkey = require "hs.hotkey"

hotkey.bind(modkey, "space", function() tiling.cycleLayout() end)
--hotkey.bind(modkey, "j", function() tiling.cycle(1) end)
--hotkey.bind(modkey, "k", function() tiling.cycle(-1) end)
--hotkey.bind(modkey, "space", function() tiling.promote() end)
hotkey.bind(modkey, "f", function() tiling.goToLayout("fullscreen") end)

-- If you want to set the layouts that are enabled
tiling.set('layouts', {
  'fullscreen', 'main-vertical'
})
--
-- [[ Windows ]] --
--

-- Set window animation off. It's much smoother.
hs.window.animationDuration = 0

-- Remove window shadows
hs.window.setShadows(true)
