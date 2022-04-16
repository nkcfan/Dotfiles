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

