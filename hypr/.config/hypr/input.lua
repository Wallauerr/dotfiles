-- Personal input overrides migrated from input.conf to the Quattro Lua format.

hl.config({
  input = {
    -- Keyboard layout and variant.
    kb_layout = "us",
    kb_variant = "intl",

    -- Omarchy defaults to compose:caps (CapsLock as Compose key).
    -- Clear it so CapsLock behaves as a plain Caps Lock.
    kb_options = "",

    -- Speed of keyboard repeat.
    repeat_rate = 40,
    repeat_delay = 600,

    -- Start with numlock on by default.
    numlock_by_default = true,

    -- Mouse sensitivity (default: 0).
    sensitivity = -0.8,

    touchpad = {
      -- Control the speed of your scrolling.
      scroll_factor = 0.4,
    },
  },
})

-- App-specific touchpad scroll speeds.
o.window("(Alacritty|kitty)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })