-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
-- This table will hold the configuration.
local config = {}
-- local wsl_domains = wezterm.default_wsl_domains()
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end
-- This is where you actually apply your config choices
config.animation_fps = 10
-- config.enable_scroll_bar = true
config.cursor_blink_ease_in = "Constant"
config.freetype_load_target = "Normal"
-- config.integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }
config.integrated_title_buttons = {}
config.cursor_blink_ease_out = "Constant"
config.show_new_tab_button_in_tab_bar = false
config.hide_mouse_cursor_when_typing = true
config.line_height = 1
-- config.term = "wezterm"

config.window_frame = {
	inactive_titlebar_bg = "#000000",
	active_titlebar_bg = "#000000",
	inactive_titlebar_fg = "#cccccc",
	active_titlebar_fg = "#ffffff",
	-- inactive_titlebar_border_bottom = "#2b2042",
	-- active_titlebar_border_bottom = "#2b2042",
	button_fg = "#000000",
	button_bg = "#000000",
	button_hover_fg = "#000000",
	button_hover_bg = "#000000",
}

-- Below is some fancy tab settings
-- For example, changing the color scheme:
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.6
config.warn_about_missing_glyphs = false
-- config.win32_system_backdrop = "Tabbed"
config.color_scheme = "MaterialDesignColors"
-- config.color_scheme = "Glacier"
config.colors = {
	background = "#000000",
	selection_fg = "#1c2128",
	selection_bg = "#286fff",
	cursor_bg = "#7ce38b",
	cursor_border = "#286fff",
	cursor_fg = "#1c2128",
}

config.font = wezterm.font({ family = "JetBrainsMono Nerd Font" })

-- config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
-- config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Italic" })
-- config.font.antialias = "None"

config.font = wezterm.font({ family = "JetBrainsMono Nerd Font" })

config.font_rules = {
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({
			family = "JetBrainsMono Nerd Font",
			weight = "Bold",
			style = "Italic",
		}),
	},
	{
		italic = false,
		intensity = "Bold",
		font = wezterm.font({
			family = "JetBrainsMono Nerd Font",
			weight = "Bold",
		}),
	},
	{
		italic = true,
		intensity = "Normal",
		font = wezterm.font({
			family = "JetBrainsMono Nerd Font",
			style = "Italic",
		}),
	},
}

-- config.exit_behavior = "Hold"
-- config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
-- config.default_prog = { "ubuntu", "run", "bash" }
config.default_prog = { "pwsh", "--nologo" }
config.enable_kitty_graphics = true
config.audible_bell = "Disabled"
config.window_padding = {
	left = 0,
	right = 0,
	top = 2,
	bottom = 0,
}

config.font_size = 11.25
config.keys = {
	{
		key = "|",
		mods = "CTRL|SHIFT",
		action = wezterm.action({
			SplitHorizontal = { domain = "CurrentPaneDomain" },
		}),
	},
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	{
		key = "-",
		mods = "CTRL",
		action = wezterm.action.DecreaseFontSize,
	},
	{
		key = "=",
		mods = "CTRL",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		key = "0",
		mods = "CTRL",
		action = wezterm.action.ResetFontAndWindowSize,
	},

	-- Turn off the default CMD-m Hide action, allowing CMD-m to
	-- be potentially recognized and handled by the tab

	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(-1),
	},

	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(1),
	},
}
config.mouse_bindings = {
	-- paste
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act({ PasteFrom = "Clipboard" }),
	},
}
-- and finally, return the configuration to wezterm
return config
