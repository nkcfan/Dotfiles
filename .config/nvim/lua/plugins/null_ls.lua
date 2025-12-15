-- ref: https://gitlab.com/LongerHV/.dotfiles/-/blob/master/.config/nvim/lua/config/language.lua

-- local map = function(type, key, value)
--     vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true })
-- end
--
-- local custom_attach = function(client)
--     map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
--     map("n", "<Leader>ra", "<cmd>Telescope lsp_code_actions<CR>")
--     map("n", "g=", "<cmd>lua vim.lsp.buf.format()<CR>")
--     map("v", "g=", "<cmd>lua vim.lsp.buf.format()<CR>")
-- end
--
-- function null_ls_setup()
--     local null_ls = require("null-ls")
--     null_ls.setup({
--         on_attach = custom_attach,
--         diagnostics_format = "[#{s}] #{m} (#{c})",
--         sources = {
--             -- Python
--             -- null_ls.builtins.formatting.autopep8,
--             -- null_ls.builtins.formatting.black,
--             null_ls.builtins.formatting.yapf,
--             null_ls.builtins.formatting.isort,
--             null_ls.builtins.formatting.ruff,
--             null_ls.builtins.diagnostics.ruff,
--             null_ls.builtins.diagnostics.flake8.with({
--                 extra_args = { "--append-config", vim.fn.expand("~/.config/flake8") },
--             }),
--
--             -- JS yaml html markdown css json
--             null_ls.builtins.formatting.prettier.with({
--                 extra_args = { "--tab-width", tostring(vim.o.shiftwidth) },
--             }),
--
--             -- C/C++
--             -- Formatting is handled by clangd language server
--             -- null_ls.builtins.formatting.clang_format,
--
--             -- Markdown
--             -- null_ls.builtins.diagnostics.markdownlint,
--
--             -- Lua
--             null_ls.builtins.formatting.stylua.with({
--                 extra_args = { "--indent-type", "Spaces", "--indent-width", tostring(vim.o.shiftwidth) },
--             }),
--
--             -- Shell
--             null_ls.builtins.diagnostics.shellcheck,
--             null_ls.builtins.code_actions.shellcheck,
--
--             -- Spell checking
--             null_ls.builtins.diagnostics.codespell.with({
--                 disabled_filetypes = { "", "messages" },
--                 args = { "--builtin", "clear,rare,code", "-" },
--             }),
--
--             -- Prose
--             null_ls.builtins.diagnostics.vale,
--             null_ls.builtins.diagnostics.alex,
--             null_ls.builtins.hover.dictionary,
--
--             -- XML
--             null_ls.builtins.formatting.xmllint,
--
--             -- code actions
--             null_ls.builtins.code_actions.gitsigns,
--             null_ls.builtins.code_actions.gitrebase,
--         },
--     })
-- end
--
-- return {
--     {
--         "jose-elias-alvarez/null-ls.nvim",
--         config = null_ls_setup,
--     },
-- }

return {
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                python = { "flake8", "ruff" },
                sh = { "shellcheck" },
                markdown = { "markdownlint" },
            }

            -- Add custom flake8 config file
            lint.linters.flake8.args = {
                "--append-config=" .. vim.fn.expand("~/.config/flake8"),
                "--format=%(path)s:%(row)d:%(col)d: %(code)s %(text)s",
                "--stdin-display-name",
                function() return vim.api.nvim_buf_get_name(0) end,
                "-",
            }

            -- Configure flake8 to show errors as errors and warnings as warnings
            -- E*** and F*** are errors, W*** are warnings
            lint.linters.flake8.parser = function(output, bufnr)
                local diagnostics = {}
                local severity_map = {
                    E = vim.diagnostic.severity.ERROR,
                    F = vim.diagnostic.severity.ERROR,
                    W = vim.diagnostic.severity.WARN,
                    C = vim.diagnostic.severity.WARN,
                    N = vim.diagnostic.severity.INFO,
                }

                for line in output:gmatch("[^\n]+") do
                    local file, row, col, code, message = line:match("([^:]+):(%d+):(%d+):%s*([A-Z]%d+)%s*(.*)")
                    if file and row and col and code and message then
                        local severity_prefix = code:sub(1, 1)
                        table.insert(diagnostics, {
                            lnum = tonumber(row) - 1,
                            col = tonumber(col) - 1,
                            message = string.format("[%s] %s", code, message),
                            severity = severity_map[severity_prefix] or vim.diagnostic.severity.WARN,
                            source = "flake8",
                        })
                    end
                end
                return diagnostics
            end

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "g=",
                function()
                    require("conform").format({ async = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                cpp = { "clang-format" },
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "yapf", "isort", "ruff_format" },
                -- You can customize some of the format options for the filetype (:help conform.format)
                rust = { "rustfmt", lsp_format = "fallback" },
                -- Conform will run the first available formatter
                javascript = { "prettierd", "prettier", stop_after_first = true },
                xml = { "xmllint" },
            },
        },
        formatters = {
            stylua = {
                prepends_args = { "--config-path", vim.fn.expand("~") .. "/.config/stylua.toml" },
            },
        },
    },
}
