local lsp = require("lspconfig")
local fuzzy = require("lspfuzzy").setup {}

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(
    vim.lsp.handlers.hover,
    {
        border = "single"
    }
)

local progress_handler = vim.lsp.handlers["$/progress"]
local send_progress = function(client_id, token, value)
    progress_handler(
        nil,
        {
            token = token,
            value = {
                kind = value.kind,
                title = value.title,
                percentage = value.percentage,
                message = value.message,
            }
        },
        {
            client_id = client_id
        }
    )
end

local map = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true})
end

local custom_attach = function(client)
    send_progress(client.id, 0, {kind = "begin", title = "on_attach"})

    -- require "completion".on_attach(client)
    require('lsp_signature').on_attach()

    map("n", "vv", "<cmd>lua vim.lsp.buf.definition()<CR>")
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    map("n", "rr", "<cmd>lua vim.lsp.buf.references()<CR>")
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", "<Leader>ra", "<cmd>Telescope lsp_code_actions<CR>")
    map("n", "<LocalLeader>fs", "<cmd>Telescope lsp_document_symbols<CR>")
    -- map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    -- map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    -- map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    -- map("n", "<Leader>gw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
    -- map("n", "<Leader>gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
    -- map("n", "<Leader>ee", "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>")
    map("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    -- map("n", "<Leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    -- map("n", "<Leader>ai", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
    -- map("n", "<Leader>ao", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")

    send_progress(client.id, 0, {kind = "end", title = "on_attach"})
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

lsp.gopls.setup {
    on_attach = custom_attach,
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true
            },
            staticcheck = true
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
                globals = {"vim"},
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
