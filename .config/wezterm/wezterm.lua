local wezterm = require 'wezterm';
return {
    keys = {
        {key='UpArrow', mods='CTRL|SHIFT', action="DisableDefaultAssignment"},
        {key='DownArrow', mods='CTRL|SHIFT', action="DisableDefaultAssignment"},
        {key='PageUp', mods='SHIFT', action="DisableDefaultAssignment"},
        {key='PageDown', mods='SHIFT', action="DisableDefaultAssignment"},
        {key='PageUp', mods='CTRL|SHIFT', action="DisableDefaultAssignment"},
        {key='PageDown', mods='CTRL|SHIFT', action="DisableDefaultAssignment"},
    },
    font = wezterm.font_with_fallback({
        "Hack",
        "LXGW WenKai Mono",
    }),
    window_padding = {
        left = 2,
        right = 2,
        top = 0,
        bottom = 0,
    },
    font_size = 10.0,
    hide_tab_bar_if_only_one_tab = true,
}
