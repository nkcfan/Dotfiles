local lsp = require("lspconfig")
local ale = require("nvim-ale-diagnostic")
local fuzzy = require("lspfuzzy").setup {}

local map = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true})
end

local custom_attach = function(client)
    print("LSP started.")
    -- require "completion".on_attach(client)

    map("n", "vv", "<cmd>lua vim.lsp.buf.definition()<CR>")
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    map("n", "rr", "<cmd>lua vim.lsp.buf.references()<CR>")
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", "<Leader>ra", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    map("n", "<LocalLeader>fs", "<cmd>Telescope lsp_document_symbols<CR>")
    -- map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    -- map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    -- map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    -- map("n", "<leader>gw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
    -- map("n", "<leader>gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
    -- map("n", "<leader>ee", "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>")
    -- map("n", "<leader>ar", "<cmd>lua vim.lsp.buf.rename()<CR>")
    -- map("n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    -- map("n", "<leader>ai", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
    -- map("n", "<leader>ao", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp.bashls.setup {on_attach = custom_attach}
lsp.clangd.setup {on_attach = custom_attach}

lsp.jedi_language_server.setup {
    on_attach = custom_attach,
    settings = {
        diagnostics = {
            enable = true
        },
        completion = {
            -- disableSnippets = true
        },
        jediSettings = {
            -- autoImportModules = {"numpy", "pandas"},
            -- debug = true
        },
        workspace = {
            extraPaths = {},
            symbols = {
                ignoreFolders = {".nox", ".tox", ".venv", "__pycache__", "venv", "build"},
                maxSymbols = 20
            }
        }
    }
}

-- lua
-- set the path to the sumneko installation
local sumneko_root_path = vim.fn.stdpath("data") .. "/lspinstall/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. "/lua-language-server"
lsp.sumneko_lua.setup {
    on_attach = custom_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = (function()
                    local path = vim.split(package.path, ";")
                    table.insert(path, "?.lua")
                    table.insert(path, "?/init.lua")
                    table.insert(path, "?/?.lua")
                    table.insert(path, "lua/?.lua")
                    table.insert(path, "lua/?/init.lua")
                    return path
                end)()
                -- path = vim.split(package.path, ";")
                -- path = {"?.lua", "?/init.lua", "?/?.lua"}
            },
            diagnostics = {
                enable = true,
                -- Get the language server to recognize the `vim` global
                -- globals = {"hs", "vim", "it", "describe", "before_each", "after_each"},
                disable = {"lowercase-global"}
            },
            workspace = {
                ignoreDir = {},
                maxPreload = 1000,
                preloadFileSize = 100,
                useGitIgnore = true,
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                }
            }
        }
    }
}
