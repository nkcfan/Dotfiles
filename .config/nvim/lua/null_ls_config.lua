-- ref: https://gitlab.com/LongerHV/.dotfiles/-/blob/master/.config/nvim/lua/config/language.lua
local null_ls = require("null-ls")

local map = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true})
end

local custom_attach = function(client)
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", "<Leader>ra", "<cmd>Telescope lsp_code_actions<CR>")
    map("n", "g=", "<cmd>lua vim.lsp.buf.format()<CR>")
    map("v", "g=", "<cmd>lua vim.lsp.buf.format()<CR>")
end

null_ls.setup({
    on_attach = custom_attach,
    diagnostics_format = "[#{s}] #{m} (#{c})",
    sources = {
        -- Python
        -- null_ls.builtins.formatting.autopep8,
        -- null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.yapf,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.ruff,
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.diagnostics.flake8.with({
            extra_args = { "--append-config", vim.fn.expand("~/.config/flake8") }
        }),

        -- JS yaml html markdown css json
        null_ls.builtins.formatting.prettier.with({
            extra_args = { "--tab-width", tostring(vim.o.shiftwidth) }
        }),

        -- C/C++
        -- Formatting is handled by clangd language server
        -- null_ls.builtins.formatting.clang_format,

        -- Markdown
        -- null_ls.builtins.diagnostics.markdownlint,

        -- Lua
        null_ls.builtins.formatting.stylua.with {
            extra_args = { "--indent-type", "Spaces", "--indent-width", tostring(vim.o.shiftwidth) }
        },

        -- Shell
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.code_actions.shellcheck,

        -- Spell checking
        null_ls.builtins.diagnostics.codespell.with({
            disabled_filetypes = { "", "messages" },
            args = { "--builtin", "clear,rare,code", "-" }
        }),

        -- Prose
        null_ls.builtins.diagnostics.vale,
        null_ls.builtins.diagnostics.alex,
        null_ls.builtins.hover.dictionary,

        -- XML
        null_ls.builtins.formatting.xmllint,

        -- code actions
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.gitrebase,
    },
})
