local wezterm = require 'wezterm'

local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    -- table.insert(launch_menu, {
    --     label = "Git Bash",
    --     args = { "%UserProfile%/scoop/apps/git/current/usr/bin/bash.exe"},
    -- })

    table.insert(launch_menu, {
        label = "PowerShell",
        args = { "powershell.exe", "-NoLogo" },
    })

    -- Find installed visual studio version(s) and add their compilation
    -- environment command prompts to the menu
    for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files (x86)")) do
        local year = vsvers:gsub("Microsoft Visual Studio/", "")
        table.insert(launch_menu, {
            label = "x64 Native Tools VS " .. year,
            args = {
                "cmd.exe",
                "/k",
                "C:/Program Files (x86)/" .. vsvers .. "/BuildTools/VC/Auxiliary/Build/vcvars64.bat",
            },
        })
    end

    -- Enumerate any WSL distributions that are installed and add those to the menu
    local success, wsl_list, wsl_err = wezterm.run_child_process({ "wsl.exe", "-l" })
    -- `wsl.exe -l` has a bug where it always outputs utf16:
    -- https://github.com/microsoft/WSL/issues/4607
    -- So we get to convert it
    wsl_list = wezterm.utf16_to_utf8(wsl_list)

    for idx, line in ipairs(wezterm.split_by_newlines(wsl_list)) do
        -- Skip the first line of output; it's just a header
        if idx > 1 then
            -- Remove the "(Default)" marker from the default line to arrive
            -- at the distribution name on its own
            local distro = line:gsub(" %(Default%)", "")

            -- Add an entry that will spawn into the distro with the default shell
            table.insert(launch_menu, {
                label = distro .. " (WSL default shell)",
                args = { "wsl.exe", "--distribution", distro },
            })

            -- Here's how to jump directly into some other program; in this example
            -- its a shell that probably isn't the default, but it could also be
            -- any other program that you want to run in that environment
            table.insert(launch_menu, {
                label = distro .. " (WSL zsh login shell)",
                args = { "wsl.exe", "--distribution", distro, "--exec", "/bin/zsh", "-l" },
            })
        end
    end
end

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
    font_rules = {
        {
            italic = true,
            intensity = "Bold",
            font = wezterm.font("Hack", {italic=true, weight="Bold"}),
        },
        {
            intensity = "Bold",
            font = wezterm.font("Hack", {weight="Bold"}),
        },
    },
    window_padding = {
        left = 2,
        right = 2,
        top = 0,
        bottom = 0,
    },
    font_size = 10.0,
    hide_tab_bar_if_only_one_tab = true,
    launch_menu = launch_menu,
    -- ssh_backend = "Ssh2",
}
