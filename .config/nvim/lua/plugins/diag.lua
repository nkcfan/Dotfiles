vim.diagnostic.config({
    underline = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
    virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR },
    },
    signs = {
        severity = { min = vim.diagnostic.severity.HINT },
    },
})

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
