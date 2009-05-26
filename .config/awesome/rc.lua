-- Standard awesome library
require("awful")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Dynamic tagging library
require("shifty")
-- Widget library
require("wicked")


-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- The default is a dark theme
--theme_path = "/usr/share/awesome/themes/default/theme.lua"
-- Uncommment this for a lighter theme
-- theme_path = "/usr/share/awesome/themes/sky/theme.lua"
theme_path = "/home/lloyda2/.config/awesome/mytheme/theme.lua"

-- Actually load theme
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
browser  = "firefox"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-- Table of clients that should be set floating. The index may be either
-- the application class or instance. The instance is useful when running
-- a console app in a terminal like (Music on Console)
--    xterm -name mocp -e mocp
--floatapps =
--{
--    -- by class
--    ["MPlayer"] = true,
--    ["pinentry"] = true,
--   ["gimp"] = true,
--    -- by instance
--    ["mocp"] = true
--}

-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
apptags =
{
    -- ["Firefox"] = { screen = 1, tag = 2 },
    -- ["mocp"] = { screen = 2, tag = 4 },
}

-- Define if we want to use titlebar on all applications.
use_titlebar = true

-- Applications to NOT have a titlebar when use_titlebar is true.
notitlebarapps = 
{
-- by class
["Audacious"] = true,
["Navigator"] = true,
["urxvt"] = true,
}
-- }}}

-- {{{ SHIFTY: configured tags
shifty.config.tags = {
  ["main"] = { exclusive = false, solitary = false, position = 1, init = true, screen = 1, slave = true },
  ["web"] = { exclusive = true, solitary = true, position = 9, spawn = browser },
  ["doc"] = { exclusive = true, solitary = true, position = 8 },
  ["media"] = { exclusive = true, solitary = false, position = 7 },
  ["chat"] = { exclusive = false, solitary = true, position = 6 },
  ["dev"] = { exclusive = false, solitary = false, position = 2 },
}
-- }}}
--
-- {{{ SHIFTY: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
  { match = { "Vimperator","Gran Paradiso","Firefox","Midori" }, tag = "web" },
  { match = { "Document Viewer" },                               tag = "doc" },
  { match = { "Audacious","gtkpod" },                            tag = "media" },
  { match = { "Pidgin" },                                        tag = "chat" },
  { match = { "GIMP","gimp" },                                   tag = "gimp" },
}
-- }}}

-- {{{ SHIFTY: default tag creation rules
-- parameter description
--  * floatBars : if floating clients should always have a title bar
--  * guess_name : whether shifty should try and guess tag names when
--      creating new (unconfigured) tags
--  * guess_position : as above, but for position parameter
--  * run : function to exec when shifty creates a new tag
--  * remember_index : ?
--  * all other parameters (e.g. layout, mwfact) follow awesome's tag API
shifty.config.defaults={
  layout = awful.layout.suit.tile,
  ncol = 1,
  mwfact = 0.50,
  guess_name = true,
  guess_position = true,
  run = function(tag)
  end,
}
-- }}}


-- {{{ Wibox
-- Create a textbox widget
mytextbox = widget({ type = "textbox", align = "right" })
-- Set the default text in textbox
mytextbox.text = "<b><small> " .. awesome.release .. " </small></b>"

-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mysystemmenu = {
   { "lock", "xscreensaver-command -lock" },
   { "suspend", "sudo pm-suspend --quirk-vbe-post" },
   { "reboot", "sudo reboot" },
   { "halt", "sudo halt" }
}

mymainmenu = awful.menu.new({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                        { "system", mysystemmenu },
                                        { "open terminal", terminal }
                                      }
                            })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })

-- Create a systray
mysystray = widget({ type = "systray", align = "right" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, function (tag) tag.selected = not tag.selected end),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ align = "left" })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = widget({ type = "imagebox", align = "right" })
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    memwidget = widget({
                          type = 'textbox',
                          name = 'memwidget',
                          align = "right"
                       })
    wicked.register(memwidget, wicked.widgets.mem,
                    ' <span color="' .. beautiful.bg_focus .. '" weight="bold">Memory: </span>$1% ($2 of $3 MB)   ', 5, nil, {2, 3, 4})

    cpuwidget = widget({
                          type = 'textbox',
                          name = 'cpuwidget',
                          align = "right"
                       })
    wicked.register(cpuwidget, wicked.widgets.cpu, '<span color="' .. beautiful.bg_focus .. '" weight="bold">CPU 1: </span>$2%    <span color="' .. beautiful.bg_focus .. '" weight="bold">CPU 2: </span>$3%   ', 5, nil, {0, 2, 2})

    mpdwidget = widget({
                          type = 'textbox',
                          name = 'mpdwidget',
                       })
--    wicked.register(mpdwidget, wicked.widgets.mpd, '<span color="' .. beautiful.bg_focus .. '" weight="bold">Playing: </span>$1')
    wicked.register(mpdwidget, wicked.widgets.mpd,
                    function (widget, args) 
                       if args[1]:find('volume:') == nil then
                          return '  <span color="' .. beautiful.bg_focus .. '" weight="bold">Playing: </span>' .. args[1]
                       else
                          return ''
                       end
                    end)

    function battery_info()
       local f = io.popen('acpi')
       local line = f:read()
       f:close()

       local percent
       local status
       local time


       if line:find('Discharging') ~= nil then
          status = 'discharging'
       elseif line:find('Full') ~= nil then
          status = 'full'
       elseif line:find('Charging') ~= nil then
          status = 'charging'
       end

--       local percents = line:match("%d+%%")
       percent = line:match('%d+%%')

       return {percent, status, time}
    end

    batterywidget = widget({
                              type = 'textbox',
                              name = 'batterywidget',
                              align = "left"
                           })

    wicked.register(batterywidget, battery_info, '<span color="' .. beautiful.bg_focus .. '" weight="bold">Battery: </span> $1 ($2)')


    -- Create the wibox
    mywibox[s] = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = { mylauncher,
                           mytaglist[s],
                           mpdwidget,
                           mypromptbox[s],
                           cpuwidget,
                           memwidget,
                           batterywidget,
                           mytextbox,
                           mylayoutbox[s],
                           s == 1 and mysystray or nil }

    mywibox[s].screen = s
end
-- }}}

-- {{{ SHIFTY: initialize shifty
-- the assignment of shifty.taglist must always be after it's actually
-- initialized with awful.widget.taglist.new()
shifty.taglist = mytaglist
shifty.init()
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "h",  awful.tag.viewprev       ),
    awful.key({ modkey,           }, "l",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    -- SHIFTY: keybindings specific to shifty
    awful.key({ modkey, "Shift" }, "d", shifty.del),       -- delete a tag
    awful.key({ modkey, "Shift" }, "n", shifty.send_prev), -- move client to prev
    awful.key({ modkey,         }, "n", shifty.send_next), -- move client to next
    awful.key({ modkey,"Control"}, "n", function()
      shifty.tagtoscr(awful.util.cycle(screen.count(), mouse.screen +1))
    end), -- move client to next tag (?)
    awful.key({ modkey,         }, "a", shifty.add),       -- create a new tag
    awful.key({ modkey,         }, "r", shifty.rename),    -- rename a tag
    awful.key({ modkey, "Shift" }, "a", function()         -- nopopup new tag
      shifty.add({ nopopup = true }) 
    end),


    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus( 1)       end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus(-1)       end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({                   }, "F12",    function () awful.util.spawn(terminal) end),

    awful.key({ modkey,           }, "Right", function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "Left",  function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "Left",  function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "Left",  function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "Right", function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Media keys
    awful.key({ }, "XF86AudioPlay",        function () awful.util.spawn('mpc toggle')               end),
    awful.key({ }, "XF86AudioStop",        function () awful.util.spawn('mpc stop')                 end),
    awful.key({ }, "XF86AudioPrev",        function () awful.util.spawn('mpc prev')                 end),
    awful.key({ }, "XF86AudioNext",        function () awful.util.spawn('mpc next')                 end),

    awful.key({ }, "XF86AudioMute",        function () awful.util.spawn('amixer set Master toggle') end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn('amixer set Master 1-')     end),
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn('amixer set Master 1+')     end),

    -- Function keys
    awful.key({ }, "XF86ScreenSaver", function () awful.util.spawn('xscreensaver-command -lock')  end),
    awful.key({ }, "XF86Sleep",       function () awful.util.spawn('pm-suspend --quirk-vbe-post') end),

    -- Prompt
    awful.key({ "Mod1" }, "F2", function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "F4",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ "Mod1"            }, "F4",     function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey }, "t", awful.client.togglemarked),
    awful.key({ modkey,}, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- SHIFTY: assign client keys to shifty for use in match() function (manage
-- hook)
shifty.config.clientkeys = clientkeys

-- compute the maximum number of digits we need, limited to 9
for i=1, ( shifty.config.maxtags or 9 ) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, i,
                  function ()
                    local t = awful.tag.viewonly(shifty.getpos(i))
                  end),
        awful.key({ modkey, "Control" }, i,
                  function ()
                    local t = shifty.getpos(i)
                    t.selected = not t.selected
                  end),
        awful.key({ modkey, "Control", "Shift" }, i,
                  function ()
                    if client.focus then
                      awful.client.toggletag(shifty.getpos(i))
                    end
                  end),
  -- move clients to other tags
        awful.key({ modkey, "Shift" }, i,
                  function ()
                    if client.focus then
                      t = shifty.getpos(i)
                      awful.client.movetotag(t)
                      awful.tag.viewonly(t)
                    end
                  end)
        )
end

-- Set keys
root.keys(globalkeys)
-- }}}

--[[ Placeholder: for end users who want to customize the behavior of new
--client appearances.
--
--Otherwise shifty.lua provides a manage hook already.
awful.hooks.manage.register(function (c, startup) end)
--]]--

-- {{{ Hooks
-- Hook function to execute when focusing a client.
awful.hooks.focus.register(function (c)
    if not awful.client.ismarked(c) then
        -- set the client's border color
        c.border_color = beautiful.border_focus
        -- give the client full opacity
        c.opacity = 1
        -- raise the client
        c:raise()
    end
end)

-- Hook function to execute when unfocusing a client.
awful.hooks.unfocus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
        c.opacity = 0.8
    end
end)

-- Hook function to execute when marking a client
awful.hooks.marked.register(function (c)
    c.border_color = beautiful.border_marked
end)

-- Hook function to execute when unmarking a client.
awful.hooks.unmarked.register(function (c)
    c.border_color = beautiful.border_focus
end)

-- Hook function to execute when the mouse enters a client.
awful.hooks.mouse_enter.register(function (c)
    -- Sloppy focus, but disabled for magnifier layout
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- Hook function to execute when a new client appears.
awful.hooks.manage.register(function (c, startup)
    -- If we are not managing this application at startup,
    -- move it to the screen where the mouse is.
    -- We only do it for filtered windows (i.e. no dock, etc).
    if not startup and awful.client.focus.filter(c) then
        c.screen = mouse.screen
    end

    local cls = c.class
    local inst = c.instance
    if use_titlebar then
        -- Add a titlebar
       if notitlebarapps[cls] or notitlebarapps[inst] or c.fullscreen then
       else 
          awful.titlebar.add(c, { modkey = modkey })
       end
    end
    -- Add mouse bindings
    c:buttons(awful.util.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ modkey }, 1, awful.mouse.client.move),
        awful.button({ modkey }, 3, awful.mouse.client.resize)
    ))
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal

    -- Check if the application should be floating.
    if floatapps[cls] then
        awful.client.floating.set(c, floatapps[cls])
    elseif floatapps[inst] then
        awful.client.floating.set(c, floatapps[inst])
    end

    -- Check application->screen/tag mappings.
    local target
    if apptags[cls] then
        target = apptags[cls]
    elseif apptags[inst] then
        target = apptags[inst]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(tags[target.screen][target.tag], c)
    end

    -- Do this after tag mapping, so you don't see it on the wrong tag for a split second.
    client.focus = c

    -- Set key bindings
    c:keys(clientkeys)

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- awful.client.setslave(c)

    -- Honor size hints: if you want to drop the gaps between windows, set this to false.
    -- c.size_hints_honor = false
end)

-- Hook function to execute when arranging the screen.
-- (tag switch, new client, etc)
awful.hooks.arrange.register(function (screen)
    local layout = awful.layout.getname(awful.layout.get(screen))
    if layout and beautiful["layout_" ..layout] then
        mylayoutbox[screen].image = image(beautiful["layout_" .. layout])
    else
        mylayoutbox[screen].image = nil
    end

    -- Give focus to the latest client in history if no window has focus
    -- or if the current window is a desktop or a dock one.
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end
end)

-- Hook called every minute
awful.hooks.timer.register(10, function ()
    mytextbox.text = os.date("<span weight='bold'> %a %b %d, %H:%M </span>")
end)
-- }}}


xcompmgrcmd = 'xcompmgr -c -t-5 -l-5 -r4.2 -o.55'

awful.util.spawn(xcompmgrcmd)
-- also start xcompmgr on second monitor if connected
if screen.count() > 1 then
   awful.screen.focus(1)
   awful.util.spawn(xcompmgrcmd)
   awful.screen.focus(0)
end
awful.util.spawn('nm-applet')
awful.util.spawn('xscreensaver')
