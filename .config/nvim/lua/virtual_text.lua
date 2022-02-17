-- ref: https://www.reddit.com/r/neovim/comments/m7ne92/how_to_redraw_lsp_diagnostics/?utm_source=share&utm_medium=web2x&context=3
-- ref: https://github.com/neovim/neovim/issues/14825#issuecomment-1017482249
local virtual_text = {}

virtual_text.show = true

virtual_text.toggle = function()
    virtual_text.show = not virtual_text.show
    if virtual_text.show then
        vim.diagnostic.enable()
    else
        vim.diagnostic.disable()
    end
end

return virtual_text
