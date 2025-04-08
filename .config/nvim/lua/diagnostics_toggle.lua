local diagnostic = {}

diagnostic.enabled = true

diagnostic.toggle = function()
    diagnostic.enabled = not diagnostic.enabled
    if diagnostic.enabled then
        vim.diagnostic.enable(true)
    else
        vim.diagnostic.enable(false)
    end
end

return diagnostic

