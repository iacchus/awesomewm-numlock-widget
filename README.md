# A simple NUM LOCK widget for Awesome

(changed from original https://github.com/stefano-m/awesome-numlock_widget)

(**See also** the [AwesomeWM Caps Lock widget](https://github.com/iacchus/awesomewm-capslock-widget))

Useful when you have a keyboard that does not have a NUM LOCK indicator.

This widget is really simple and parses the output of `xset` to figure out
whether NUM LOCK is active or not. (Hint: you need the `xset` utility for this
widget to work)

This script is simple and you can edit the file `init.lua` if you want to change
it.

# Installation

1. Ensure that `xset` is available to you on your system.
2. Clone this repository in your `~/.config/awesome/` folder.
   ```
   cd ~/.config/awesome/
   git clone git@github.com:iacchus/awesomewm-numlock-widget.git
   ```
3. Refer to **Usage** (below.) and follow it's three steps.
4. Restart Awesome (e.g. press `modkey + Control + R` or run `awesome-client
   "awesome.restart()"` from a terminal).

# Usage

For **Awesome 4.x**, add the following to your `~/.config/awesome/rc.lua`:

``` lua
-- FIRST. If you just cloned the repo in ~/.config/awesome/ require the module
--          at the beginning of the file (anywhere there should be ok.):
local numlock = require("awesomewm-numlock-widget")

-- etcetc... more config here...

-- SECOND. Add the widget to the wibox: Look for "-- Right widgets",
--           as shown below, and add the line `numlock,` where you want to
--           see the widget (pay attention to the ending commas `,`):
    s.mywibox:setup {

      -- more config here...

      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        wibox.widget.systray(),
        numlock,
        -- more config here

-- THIRD. Add the keybinding to `global_keys` so that the widget can change state
--          on keypress, by adding the line `numlock.key` there:
--
-- {{{ Key bindings
local globalkeys = awful.util.table.join(
  numlock.key,
-- more config follows
```

Now:

* when NUM LOCK is active, a **+numlock** will be displayed
* when NUM LOCK is inactive, a text **-numlock** will be displayed


These can be changed by changing the `activated` and `deactivated`
attributes of the widget as
[Pango markup](https://developer.gnome.org/pygtk/stable/pango-markup-language.html)
strings. You will probably need to adjust the `forced_width` attribute too.

For example:

``` lua
local numlock = require("awesomewm-numlock-widget")
numlock.forced_width = 35
numlock.activated = "<u>NUM</u>"
numlock.deactivated = "<u>num</u>"
```

When the mouse is over the widget, a tooltip that says `Num Lock on`/`Num
Lock off` is also shown.

# Contributing

If you have ideas about how to make this better, feel free to open an issue or
submit a pull request.
