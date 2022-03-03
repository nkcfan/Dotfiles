require("diaglist").init({
    -- optional settings
    -- below are defaults
    debug = false,

    -- increase for noisy servers
    debounce_ms = 150,
})

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
