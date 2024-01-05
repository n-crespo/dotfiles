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

config.cursor_blink_ease_in = "Constant"
config.freetype_load_target = "Normal"
config.integrated_title_buttons = {}
config.cursor_blink_ease_out = "Constant"
config.show_new_tab_button_in_tab_bar = false
config.hide_mouse_cursor_when_typing = true
config.line_height = 1
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.default_prog = { "pwsh", "--nologo" }
config.enable_kitty_graphics = true
config.audible_bell = "Disabled"
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.6
config.warn_about_missing_glyphs = true
config.color_scheme = "MaterialDesignColors"
config.font_size = 11.25
config.adjust_window_size_when_changing_font_size = false
config.switch_to_last_active_tab_when_closing_tab = true
-- config.enable_scroll_bar = true
-- config.integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }
-- config.exit_behavior = "Hold"
-- config.enable_tab_bar = false
-- config.default_prog = { "ubuntu", "run", "bash" }
-- config.term = "wezterm"
-- config.win32_system_backdrop = "Tabbed"

-- colors and padding
config.colors = {
	background = "#000000",
	selection_fg = "#1c2128",
	selection_bg = "#286fff",
	cursor_bg = "#89ca78",
	-- cursor_bg = "#7ce38b",
	cursor_border = "#286fff",
	cursor_fg = "#1c2128",
}
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- custom tabs
-- The filled in variant of the < symbol and > symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
---@diagnostic disable-next-line: lowercase-global
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

-- background around tabs
config.window_frame = { active_titlebar_bg = "#000000" }
-- actual tab config
---@diagnostic disable-next-line: unused-local, redefined-local
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#000000"
	local background = "#101010"
	local foreground = "#808080"

	if tab.is_active then
		background = "#252525"
		foreground = "#c0c0c0"
	elseif hover then
		background = "#3b3052"
		foreground = "#909090"
	end

	local edge_foreground = background
	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

-- font config
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

-- key and mouase binding
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
		action = wezterm.action.ResetFontSize,
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
