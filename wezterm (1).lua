local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font("JetBrains Mono Regular")
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.window_background_opacity = 0.75
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

return config