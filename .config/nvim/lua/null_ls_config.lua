-- ref: https://gitlab.com/LongerHV/.dotfiles/-/blob/master/.config/nvim/lua/config/language.lua
local null_ls = require("null-ls")

local map = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true})
end

local custom_attach = function(client)
    print("NullLs started.")
    -- require "completion".on_attach(client)

    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", "<Leader>ra", "<cmd>Telescope lsp_code_actions<CR>")
    -- map("n", "<Leader>ee", "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>")
    map("n", "<Leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    map("v", "<Leader>fm", ":lua vim.lsp.buf.range_formatting()<CR>")
end

null_ls.setup({
    on_attach = custom_attach,
    diagnostics_format = "[#{s}] #{m} (#{c})",
    sources = {
        -- Python
        -- null_ls.builtins.formatting.autopep8,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.flake8,

        -- JS yaml html markdown
        null_ls.builtins.formatting.prettier,

        -- C/C++
        -- Formatting is handled by clangd language server
        -- null_ls.builtins.formatting.clang_format,

        -- Markdown
        -- null_ls.builtins.diagnostics.markdownlint,

        -- Lua
        -- cargo install stylua
        -- add ~/.cargo/bin to PATH
        -- null_ls.builtins.formatting.stylua,

        -- Shell
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.code_actions.shellcheck,

        -- Spell checking
        null_ls.builtins.diagnostics.codespell.with({
            disabled_filetypes = { "" },
            args = { "--builtin", "clear,rare,code", "-" }
        }),

        -- Prose
        null_ls.builtins.diagnostics.vale,
        -- null_ls.builtins.diagnostics.alex,
        null_ls.builtins.hover.dictionary,

        -- XML
        null_ls.builtins.formatting.xmllint,
    },
})
