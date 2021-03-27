-- ref: https://www.reddit.com/r/neovim/comments/m7ne92/how_to_redraw_lsp_diagnostics/?utm_source=share&utm_medium=web2x&context=3
local virtual_text = {}

virtual_text.show = true

virtual_text.toggle = function()
    virtual_text.show = not virtual_text.show
    vim.lsp.diagnostic.display(
        vim.lsp.diagnostic.get(0, 1),
        0,
        1,
        {virtual_text = virtual_text.show}
    )
    -- cast show boolean to int
    vim.api.nvim_set_var('ale_virtualtext_cursor', virtual_text.show and 1 or 0)
end

return virtual_text
