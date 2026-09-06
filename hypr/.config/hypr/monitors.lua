-- Personal monitor configuration migrated from monitors.conf to the Quattro
-- Lua format.
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported modes with: hyprctl monitors all

local omarchy_gdk_scale = 1
hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Main monitor (ultrawide).
hl.monitor({ output = "DP-3", mode = "2560x1080@75", position = "0x0", scale = 1 })

-- Secondary monitor (ultrawide, rotated 90° to portrait).
hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@75", position = "-1080x-610", scale = 1, transform = 1 })