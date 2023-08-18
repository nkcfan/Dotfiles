return {
    "glacambre/firenvim",
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    module = false,
    build = function()
        vim.fn["firenvim#install"](0)
    end,
    config = function()
        if vim.g.started_by_firenvim == true then
            vim.g.firenvim_config = {
                globalSettings = {},
                localSettings = {
                    ['.*'] = {
                        takeover = 'never'
                    }
                }
            }
            -- Set filetypes for buffers
            local augroup = vim.api.nvim_create_augroup("firenvim", {})
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "github.com_*.txt",
                callback = function() vim.bo.filetype = "markdown" end,
                group = augroup,
            })
        end
    end,
}
