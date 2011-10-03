-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- widgets
require("vicious")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "roxterm"
editor = "emacs -nw"
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
   awful.layout.suit.floating,
   -- awful.layout.suit.fair,
   -- awful.layout.suit.fair.horizontal,
   awful.layout.suit.max,
   -- awful.layout.suit.max.fullscreen,
   -- awful.layout.suit.magnifier
   -- awful.layout.suit.spiral,
   -- awful.layout.suit.spiral.dwindle,
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
   -- Each screen has its own tag table.
   tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                 }
                       })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
local calendar = nil
local offset = 0

function remove_calendar()
   if calendar ~= nil then
      naughty.destroy(calendar)
      calendar = nil
      offset = 0
   end
end

function add_calendar(inc_offset)
   local save_offset = offset
   remove_calendar()
   offset = save_offset + inc_offset
   local datespec = os.date("*t")
   datespec = datespec.year * 12 + datespec.month - 1 + offset
   datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
   local cal = awful.util.pread("cal -m " .. datespec)
   cal = string.gsub(cal, "^%s*(.-)%s*$", "%1")
   calendar = naughty.notify({
                                text = string.format('<span font_desc="%s">%s</span>', "monospace", os.date("%Y %B %d, %a") .. "\n" .. cal),
                                timeout = 0, hover_timeout = 0.5,
                                width = 160,
                             })
end

mytextclock = awful.widget.textclock({ align = "right" })
mytextclock:add_signal("mouse::enter", function()
                                          add_calendar(0)
                                       end)
mytextclock:add_signal("mouse::leave", remove_calendar)

mytextclock:buttons(awful.util.table.join(
                       awful.button({ }, 4, function()
                                               add_calendar(-1)
                                            end),
                       awful.button({ }, 5, function()
                                               add_calendar(1)
                                            end)
                 ))


-- 
memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, 
                 function (widert, args)
                    return string.format('[ mem: %2d%% ]', args[1])
                 end, 13)

battwidget = widget({ type = "textbox" })
vicious.register(battwidget, vicious.widgets.bat, 
                 function (widert, args)
                    return string.format('[ bat: %2d%% %6s ]', args[2], args[3])
                 end, 13, "BAT0")

cpu = awful.widget.progressbar()
cpu:set_width(8)
cpu:set_height(16)
cpu:set_vertical(true)
cpu:set_background_color('#494B4F')
cpu:set_color('#AECF96')
cpu:set_gradient_colors({ '#AECF96', '#88A175', '#FF5656' })
vicious.register(cpu, vicious.widgets.cpu, "$1")

mpdwidget = widget({ type = "textbox" })
vicious.register(mpdwidget, vicious.widgets.mpd,
                 function (widget, args)
                    if args["{state}"] == "Stop" then 
                       return "[ Stopped ]"
                    else 
                       return '[ ' .. args["{Artist}"]..' - '.. args["{Title}"] .. ' ]'
                    end
                 end, 7)

-- volume widget http://awesome.naquadah.org/wiki/Farhavens_volume_widget
cardid  = 0
channel = "Master"
function volume (mode, widget)
   if mode == "update" then
      local fd = io.popen("amixer -c " .. cardid .. " -- sget " .. channel)
      local status = fd:read("*all")
      fd:close()
      local volume = string.match(status, "(%d?%d?%d)%%")
      volume = string.format("% 3d", volume)
      widget.text = string.format("[ vol: %3d%% ]", volume)
   elseif mode == "up" then
      io.popen("amixer -q -c " .. cardid .. " sset " .. channel .. " 1+"):read("*all")
      volume("update", widget)
   elseif mode == "down" then
      io.popen("amixer -q -c " .. cardid .. " sset " .. channel .. " 1-"):read("*all")
      volume("update", widget)
   else
      io.popen("amixer -c " .. cardid .. " sset " .. channel .. " toggle"):read("*all")
      volume("update", widget)
   end
end

volumewidget = widget({ type = "textbox", name = "tb_volume", align = "right" })
volumewidget:buttons({
                        button({ }, 4, function () volume("up",   volumewidget) end),
                        button({ }, 5, function () volume("down", volumewidget) end),
                        button({ }, 1, function () volume("mute", volumewidget) end)
                     })
volume("update", volumewidget)


-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
   awful.button({ }, 1, awful.tag.viewonly),
   awful.button({ modkey }, 1, awful.client.movetotag),
   awful.button({ }, 3, awful.tag.viewtoggle),
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
   mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
   -- Create an imagebox widget which will contains an icon indicating which layout we're using.
   -- We need one layoutbox per screen.
   mylayoutbox[s] = awful.widget.layoutbox(s)
   mylayoutbox[s]:buttons(awful.util.table.join(
                             awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                             awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                             awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                             awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
   -- Create a taglist widget
   mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

   -- Create a tasklist widget
   mytasklist[s] = awful.widget.tasklist(function(c)
                                            return awful.widget.tasklist.label.currenttags(c, s)
                                         end, mytasklist.buttons)


   -- Create the wibox
   mywibox[s] = awful.wibox({ position = "top", screen = s })
   -- Add widgets to the wibox - order matters
   mywibox[s].widgets = {
      {
         mylauncher,
         mytaglist[s],
         mypromptbox[s],
         layout = awful.widget.layout.horizontal.leftright
      },
      mylayoutbox[s],
      mytextclock,
      cpu,
      battwidget,
      memwidget,
      volumewidget,
      mpdwidget,
      s == 1 and mysystray or nil,
      mytasklist[s],
      layout = awful.widget.layout.horizontal.rightleft
   }
end
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
   awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
   awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
   awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

   awful.key({ modkey,           }, "Tab",
             function ()
                awful.client.focus.byidx( 1)
                if client.focus then client.focus:raise() end
             end),
   awful.key({ modkey, "Shift"   }, "Tab",
             function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
             end),
   awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

   -- Layout manipulation
   awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
   awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
   awful.key({ modkey,           }, "Up", function () awful.screen.focus_relative( 1) end),
   awful.key({ modkey,           }, "Down", function () awful.screen.focus_relative(-1) end),
   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),

   -- Standard program
   awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
   awful.key({ "Control", "Mod1"  }, "l", function () awful.util.spawn("xscreensaver-command -lock") end),
   awful.key({ modkey, "Control" }, "r", awesome.restart),
   awful.key({ modkey, "Shift"   }, "q", awesome.quit),
   awful.key({ "Control", "Mod1"  }, "Escape", function () awful.util.spawn("xkill") end),

   awful.key({ }, "XF86AudioStop", function () awful.util.spawn("mpc stop") end),
   awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("mpc prev") end),
   awful.key({ }, "XF86AudioNext", function () awful.util.spawn("mpc next") end),
   awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("mpc toggle") end),

   awful.key({ }, "XF86AudioMute",        function () volume("mute", volumewidget) end),
   awful.key({ }, "XF86AudioLowerVolume", function () volume("down", volumewidget) end),
   awful.key({ }, "XF86AudioRaiseVolume", function () volume("up",   volumewidget) end),

   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
   awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
   awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
   awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
   awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

   -- Prompt
   awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

   awful.key({ modkey }, "x",
             function ()
                awful.prompt.run({ prompt = "Run Lua code: " },
                                 mypromptbox[mouse.screen].widget,
                                 awful.util.eval, nil,
                                 awful.util.getdir("cache") .. "/history_eval")
             end),
   awful.key({ "Mod1" }, "Escape", 
             function ()
                -- If you want to always position the menu on the same place
                --mouse.coords({x=525, y=330}, true)
                awful.menu.menu_keys.down = { "Down", "Alt_L" }
                local cmenu = awful.menu.clients({ width = 245 }, true)
             end)
)

clientkeys = awful.util.table.join(
   awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
   awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
   awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
   awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
   awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
   awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
   awful.key({ modkey,           }, "m",
             function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c.maximized_vertical   = not c.maximized_vertical
             end),
   awful.key({ modkey, "Control" }, "Up",     function (c) c.maximized_vertical   = not c.maximized_vertical end),
   awful.key({ modkey, "Control" }, "Right",  function (c) c.maximized_horizontal = not c.maximized_horizontal end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
   globalkeys = awful.util.table.join(globalkeys,
                                      awful.key({ modkey }, "#" .. i + 9,
                                                function ()
                                                   local screen = mouse.screen
                                                   if tags[screen][i] then
                                                      awful.tag.viewonly(tags[screen][i])
                                                   end
                                                end),
                                      awful.key({ modkey, "Control" }, "#" .. i + 9,
                                                function ()
                                                   local screen = mouse.screen
                                                   if tags[screen][i] then
                                                      awful.tag.viewtoggle(tags[screen][i])
                                                   end
                                                end),
                                      awful.key({ modkey, "Shift" }, "#" .. i + 9,
                                                function ()
                                                   if client.focus and tags[client.focus.screen][i] then
                                                      awful.client.movetotag(tags[client.focus.screen][i])
                                                   end
                                                end),
                                      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                                                function ()
                                                   if client.focus and tags[client.focus.screen][i] then
                                                      awful.client.toggletag(tags[client.focus.screen][i])
                                                   end
                                                end))
end

clientbuttons = awful.util.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
   awful.button({ modkey }, 1, awful.mouse.client.move),
   awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = true,
                    keys = clientkeys,
                    buttons = clientbuttons } },
   -- Set Skype to always map on tags number 2 of screen 1.
   { rule = { class = "Skype" }, properties = { tag = tags[1][9] } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
                               -- Add a titlebar
                               -- awful.titlebar.add(c, { modkey = modkey })

                               -- Enable sloppy focus
                               c:add_signal("mouse::enter", function(c)
                                                               if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                                                               and awful.client.focus.filter(c) then
                                                               client.focus = c
                                                            end
                                                         end)

                               c.maximized_vertical   = false
                               c.maximized_horizontal = false

                               if not startup then
                                  -- Set the windows at the slave,
                                  -- i.e. put it at the end of others instead of setting it master.
                                  -- awful.client.setslave(c)

                                  -- Put windows in a smart way, only if they does not set an initial position.
                                  if not c.size_hints.user_position and not c.size_hints.program_position then
                                     awful.placement.no_overlap(c)
                                     awful.placement.no_offscreen(c)
                                  end
                               end
                            end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- awful.hooks.timer.register(10, function () volume("update", volumewidget) end)

-- autostart some aplications
awful.util.spawn_with_shell("/home/vaczi/usr/bin/run-once parcellite")
awful.util.spawn_with_shell("/home/vaczi/usr/bin/run-once wicd-gtk")
awful.util.spawn_with_shell("/home/vaczi/usr/bin/run-once xscreensaver")
awful.util.spawn_with_shell("/home/vaczi/usr/bin/run-once skype")

