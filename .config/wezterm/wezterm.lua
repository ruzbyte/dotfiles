-- WezTerm Configuration
-- Ported from kitty.conf with Catppuccin Mocha theme

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font settings
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 11.0
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- Disable ligatures

-- Window settings
config.window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 20,
}
config.window_background_opacity = 0.8
config.window_close_confirmation = "NeverPrompt"
config.enable_scroll_bar = false

-- Shell (use PowerShell on Windows)
if wezterm.target_triple:find("windows") then
    config.default_prog = { "pwsh.exe", "-NoLogo" }
else
    config.default_prog = { "fish" }
end

-- Disable audio bell
config.audible_bell = "Disabled"

-- Tab bar settings
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false

-- Cursor settings
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

-- Performance
config.animation_fps = 60
config.max_fps = 144

-- Catppuccin Mocha color scheme
config.colors = {
    foreground = "#CDD6F4",
    background = "#1E1E2E",
    cursor_bg = "#F5E0DC",
    cursor_fg = "#1E1E2E",
    cursor_border = "#F5E0DC",
    selection_fg = "#1E1E2E",
    selection_bg = "#F5E0DC",

    scrollbar_thumb = "#585B70",

    split = "#6C7086",

    ansi = {
        "#43465A", -- black
        "#F38BA8", -- red
        "#A6E3A1", -- green
        "#F9E2AF", -- yellow
        "#87B0F9", -- blue
        "#F5C2E7", -- magenta
        "#94E2D5", -- cyan
        "#CDD6F4", -- white
    },
    brights = {
        "#43465A", -- bright black
        "#F38BA8", -- bright red
        "#A6E3A1", -- bright green
        "#F9E2AF", -- bright yellow
        "#87B0F9", -- bright blue
        "#F5C2E7", -- bright magenta
        "#94E2D5", -- bright cyan
        "#A1A8C9", -- bright white
    },

    -- Tab bar colors
    tab_bar = {
        background = "#11111B",
        active_tab = {
            bg_color = "#CBA6F7",
            fg_color = "#11111B",
            intensity = "Bold",
        },
        inactive_tab = {
            bg_color = "#181825",
            fg_color = "#CDD6F4",
        },
        inactive_tab_hover = {
            bg_color = "#313244",
            fg_color = "#CDD6F4",
        },
        new_tab = {
            bg_color = "#181825",
            fg_color = "#CDD6F4",
        },
        new_tab_hover = {
            bg_color = "#313244",
            fg_color = "#CDD6F4",
        },
    },
}

-- Key bindings (similar to kitty defaults)
config.keys = {
    -- New tab in same directory
    {
        key = "t",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SpawnCommandInNewTab({
            cwd = wezterm.home_dir,
        }),
    },
    -- Close tab
    {
        key = "w",
        mods = "CTRL|SHIFT",
        action = wezterm.action.CloseCurrentTab({ confirm = false }),
    },
    -- Split pane horizontally
    {
        key = "d",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    -- Split pane vertically
    {
        key = "e",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
}

return config
