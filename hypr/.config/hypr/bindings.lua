-- Personal keybinding overrides migrated from Omarchy 3 to the Quattro Lua
-- format. Loaded after Omarchy's defaults (see hyprland.lua).

-- App bindings (terminal, browser, editor, file manager, web apps) now match
-- the Quattro defaults, so they're not redeclared here. Only personal
-- differences and custom window-management bindings are kept.

-- Vim motions for focus navigation (replaces the default SUPER+arrow keys).
-- The keys below were claimed by Omarchy defaults, so unbind them first.
hl.unbind("SUPER + J")  -- was: Toggle window split
hl.unbind("SUPER + K")  -- was: Keybindings menu
hl.unbind("SUPER + L")  -- was: Toggle workspace layout

o.bind("SUPER + H", "Focus on left window", hl.dsp.focus({ direction = "left" }))
o.bind("SUPER + J", "Focus on below window", hl.dsp.focus({ direction = "down" }))
o.bind("SUPER + K", "Focus on above window", hl.dsp.focus({ direction = "up" }))
o.bind("SUPER + L", "Focus on right window", hl.dsp.focus({ direction = "right" }))

-- Vim motions for moving windows.
o.bind("SUPER + SHIFT + H", "Move window left", hl.dsp.window.move({ direction = "left" }))
o.bind("SUPER + SHIFT + J", "Move window down", hl.dsp.window.move({ direction = "down" }))
o.bind("SUPER + SHIFT + K", "Move window up", hl.dsp.window.move({ direction = "up" }))
o.bind("SUPER + SHIFT + L", "Move window right", hl.dsp.window.move({ direction = "right" }))

-- Remapped default functions (SUPER+K/J/L are taken by vim motions).
o.bind("SUPER + ALT + H", "Keybindings", "omarchy-menu-keybindings")

-- Split toggle on SUPER+V (replaces Quattro's default universal paste).
hl.unbind("SUPER + V")  -- was: Universal paste
o.bind("SUPER + V", "Toggle window split", hl.dsp.layout("togglesplit"))

-- App bindings that differ from the Quattro defaults.
hl.unbind("SUPER + SHIFT + M")  -- was: Music (Spotify)
o.bind("SUPER + SHIFT + M", "Music", { webapp = "https://music.youtube.com/" })
hl.unbind("SUPER + SHIFT + G")  -- was: Signal
o.bind("SUPER + SHIFT + G", "GitHub", { webapp = "https://github.com/", focus = true })
hl.unbind("SUPER + SHIFT + W")  -- was: Omawrite
o.bind("SUPER + SHIFT + W", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })
o.bind("SUPER + SHIFT + T", "Activity", { tui = "btop" })