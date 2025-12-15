vim.diagnostic.config({
    underline = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
    virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR },
        format = function(diagnostic)
            return string.format("[%s] %s", diagnostic.source, diagnostic.message)
        end,
    },
    signs = {
        severity = { min = vim.diagnostic.severity.HINT },
    },
    float = {
        format = function(diagnostic)
            return string.format("[%s] %s", diagnostic.source, diagnostic.message)
        end,
    },
})

vim.api.nvim_set_keymap("n", "<LocalLeader>tf", '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>td", '<cmd>lua require("diagnostics_toggle").toggle()<CR>', {})

return {
    {
        "onsails/diaglist.nvim",
        config = function()
            require("diaglist").init({
                -- optional settings
                -- below are defaults
                debug = false,

                -- increase for noisy servers
                debounce_ms = 150,
            })
        end,
    },
}
