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

local diagnostic = {}

diagnostic.enabled = true

diagnostic.toggle = function()
    diagnostic.enabled = not diagnostic.enabled
    if diagnostic.enabled then
        vim.diagnostic.enable(0, nil)
    else
        vim.diagnostic.disable(0, nil)
    end
end

return diagnostic
