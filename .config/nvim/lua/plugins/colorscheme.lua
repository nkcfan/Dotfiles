local prefer_italic = vim.env.ALACRITTY_WINDOW_ID ~= nil

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = {
            style = "storm",
            styles = {
                functions = { italic = true },
                comments = { italic = prefer_italic },
                keywords = { italic = false },
            },
            sidebars = { "qf", "vista_kind", "terminal", "packer" },

            -- Change the "hint" color to the "orange" color, and make the "error" color bright red
            on_colors = function(colors)
                colors.hint = colors.orange
                colors.error = "#ff0000"
            end,
        },
    },
    {
        "navarasu/onedark.nvim",
        lazy = true,
        config = {
            style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
            transparent = false, -- Show/hide background
            term_colors = true, -- Change terminal color as per the selected theme style
            ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
            -- toggle theme style ---
            toggle_style_key = "<LocalLeader>tt", -- Default keybinding to toggle
            toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

            -- Change code style ---
            -- Options are italic, bold, underline, none
            -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
            code_style = {
                comments = "none",
                keywords = "italic",
                functions = "none",
                strings = "none",
                variables = "none",
            },

            -- Custom Highlights --
            colors = {}, -- Override default colors
            highlights = {}, -- Override highlight groups

            -- Plugins Config --
            diagnostics = {
                darker = true, -- darker colors for diagnostic
                undercurl = true, -- use undercurl instead of underline for diagnostics
                background = false, -- use background color for virtual text
            },
        },
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        config = {
            fox = "nightfox", -- Which fox style should be applied
            transparent = false, -- Disable setting the background color
            alt_nc = false, -- Non current window bg to alt color see `hl-NormalNC`
            terminal_colors = true, -- Configure the colors used when opening :terminal
            styles = {
                comments = "NONE", -- Style that is applied to comments: see `highlight-args` for options
                functions = "NONE", -- Style that is applied to functions: see `highlight-args` for options
                keywords = "NONE", -- Style that is applied to keywords: see `highlight-args` for options
                strings = "NONE", -- Style that is applied to strings: see `highlight-args` for options
                variables = "NONE", -- Style that is applied to variables: see `highlight-args` for options
            },
            inverse = {
                match_paren = false, -- Enable/Disable inverse highlighting for match parens
                visual = false, -- Enable/Disable inverse highlighting for visual selection
                search = false, -- Enable/Disable inverse highlights for search highlights
            },
            colors = {}, -- Override default colors
            hlgroups = {}, -- Override highlight groups
        },
    },
}
