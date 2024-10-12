local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

-- Window
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

-- Underlines
config.underline_thickness = 3
config.underline_position = -6

-- Cursor
config.default_cursor_style = "SteadyBar"
config.window_padding = { left = 100, right = 100, top = 50, bottom = 50 }

-- Fonts
config.font = wezterm.font({ family = "Fira Code" })
config.font_size = 22

-- Color theme
function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Macchiato"
  else
    return "Catppuccin Latte"
  end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

return config
