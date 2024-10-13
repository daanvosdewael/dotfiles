local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

-- Window
config.macos_window_background_blur = 10
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_padding = { left = 100, right = 100, top = 50, bottom = 50 }

wezterm.on("gui-startup", function(cmd)
	local _tab, _pane, window = mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)

-- Underlines
config.underline_position = -6
config.underline_thickness = 3

-- Cursor
config.default_cursor_style = "SteadyBar"

-- Fonts
config.font = wezterm.font({ family = "Fira Code" })
config.font_size = 22

-- Color theme
function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Macchiato"
	else
		return "Catppuccin Latte"
	end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- Tab bar
config.enable_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.tab_bar_at_bottom = true
config.tab_max_width = 60
config.use_fancy_tab_bar = false

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return current_dir == HOME_DIR and "."
	or string.gsub(current_dir.file_path, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab)
	local index = tonumber(tab.tab_index)
	local custom_title = tab.tab_title
	local title = get_current_working_dir(tab)

	if custom_title and #custom_title > 0 then
		title = custom_title
	end

	return string.format(" %s: %s ", index, title)
end)

wezterm.on("update-status", function(window)
	local color_scheme = window:effective_config().resolved_palette
	local bg = color_scheme.background
	local fg = color_scheme.foreground
	local date = wezterm.strftime("%a %-d %b %H:%M");

	window:set_right_status(wezterm.format({
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = " " .. date },
	}))
end)

-- Keys
config.keys = {
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
	},
	{
		key = "[",
		mods = "CMD",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "]",
		mods = "CMD",
		action = wezterm.action.ActivateTabRelative(1),
	},
}

return config
