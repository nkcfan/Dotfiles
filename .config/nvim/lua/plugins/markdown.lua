return {
    {
        "OXY2DEV/markview.nvim",
        lazy = true,     -- false recommended
        ft = "markdown", -- If you decide to lazy-load anyway

        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require('markview').setup({
                checkboxes = {
                    enable = true,

                    checked = {
                        --- Text to show
                        ---@type string
                        text = "✓",

                        --- Highlight group for "text"
                        ---@type string?
                        hl = "MarkviewCheckboxChecked",

                        --- Highlight group to add to the body
                        --- of the list item.
                        ---@type string?
                        scope_hl = nil
                    },

                    unchecked = {
                        text = "✘", hl = "MarkviewCheckboxUnchecked",
                        scope_hl = nil
                    },

                    custom = {
                        {
                            --- Text inside []
                            ---@type string
                            match_string = "-",

                            ---@type string
                            text = "◒",

                            ---@type string?
                            hl = "MarkviewCheckboxProgress",

                            ---@type string?
                            scope_hl = nil
                        }
                    }
                }
            })
        end
    },
    {
        'jakewvincent/mkdnflow.nvim',
        config = function()
            require('mkdnflow').setup({
                -- Config goes here; leave blank for defaults
                mappings = {
                    MkdnToggleToDo = {{'n', 'v'}, 'gs'},
                    MkdnNextHeading = false,
                    MkdnPrevHeading = false,
                },
            })
        end
    }
}
