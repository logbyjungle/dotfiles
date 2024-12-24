local wezterm = require 'wezterm'
local config = {}
config.font = wezterm.font 'JetBrains Mono'
config.enable_tab_bar = false
config.window_background_opacity = 0.7
config.font_size = 11
config.max_fps = 144
config.default_cursor_style = "SteadyUnderline"
config.cursor_thickness = 1
config.cursor_blink_rate = 500
config.window_decorations = "RESIZE"
config.default_prog = {"C:\\Program Files\\Git\\bin\\bash.exe"}
config.window_close_confirmation = "NeverPrompt"
return config
