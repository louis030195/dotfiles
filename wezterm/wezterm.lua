local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Font
config.font = wezterm.font('JetBrains Mono')
config.font_size = 11.0

-- Color scheme - light mode
config.color_scheme = 'One Light (Gogh)'

-- Window
config.window_padding = { left = 4, right = 4, top = 4, bottom = 4 }
config.hide_tab_bar_if_only_one_tab = true

-- OS-specific shell
local is_windows = wezterm.target_triple:find('windows') ~= nil
local is_macos = wezterm.target_triple:find('darwin') ~= nil

if is_windows then
    config.default_prog = { 'C:/Program Files/Git/bin/bash.exe', '-l' }
elseif is_macos then
    config.default_prog = { '/opt/homebrew/bin/bash', '-l' }
else
    config.default_prog = { '/bin/bash', '-l' }
end

-- Keybindings (cross-platform)
if is_windows then
    config.keys = {
        { key = '_', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        { key = '|', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
        { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },
        { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
        { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
        { key = 'UpArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
        { key = 'DownArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
    }
else
    config.keys = {
        { key = 'd', mods = 'CMD|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        { key = 'd', mods = 'CMD', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
        { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentPane { confirm = true } },
    }
end

return config
