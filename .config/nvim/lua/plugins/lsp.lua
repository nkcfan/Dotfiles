vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
})

local progress_handler = vim.lsp.handlers["$/progress"]
local send_progress = function(client_id, token, value)
    progress_handler(nil, {
        token = token,
        value = {
            kind = value.kind,
            title = value.title,
            percentage = value.percentage,
            message = value.message,
        },
    }, {
        client_id = client_id,
    })
end

local map = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true })
end

local custom_attach = function(client, bufnr)
    send_progress(client.id, 0, { kind = "begin", title = "on_attach" })

    -- require "completion".on_attach(client)
    require("lsp_signature").on_attach(sig_cfg, bufnr)

    local methods = vim.lsp.protocol.Methods

    -- https://reddit.com/r/neovim/s/eDfG5BfuxW
    if client.supports_method(methods.textDocument_inlayHint) then
        vim.keymap.set("n", "<LocalLeader>ti", function()
            vim.lsp.inlay_hint.enable(true, nil)
        end, { desc = "[t]oggle [i]nlay hints" })
        -- enable by default
        vim.lsp.inlay_hint.enable(true, nil)
    end

    map("n", "<LocalLeader>tv", "<cmd>lua require('virtual_text').toggle()<CR>")
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

    send_progress(client.id, 0, { kind = "end", title = "on_attach" })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

function lspconfig_setup()
    local lsp = require("lspconfig")
    lsp.marksman.setup({ on_attach = custom_attach })
    lsp.bashls.setup({ on_attach = custom_attach })
    lsp.clangd.setup({
        on_attach = custom_attach,
        settings = {
            clangd = {
                diagnostics = {
                    enable = true,
                },

                -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
                -- Be aware that you also will need to properly configure your LSP server to
                -- provide the inlay hints.
                inlay_hints = {
                    enabled = true,
                    exclude = {}, -- filetypes for which you don't want to enable inlay hints
                },
            },
        },
    })

    lsp.rust_analyzer.setup({
        on_attach = custom_attach,
        settings = {
            ["rust-analyzer"] = {
                diagnostics = {
                    enable = true,
                },
                cargo = {
                    allFeatures = true,
                },
            },
        },
    })
    lsp.pyright.setup({
        on_attach = custom_attach,
        settings = {
            diagnostics = {
                enable = true,
            },
            completion = {
                -- disableSnippets = true
            },
            workspace = {
                extraPaths = {},
                symbols = {
                    ignoreFolders = { ".nox", ".tox", ".venv", "__pycache__", "venv", "build" },
                    maxSymbols = 20,
                },
            },
        },
    })

    lsp.gopls.setup({
        on_attach = custom_attach,
        cmd = { "gopls", "serve" },
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
    })
    -- lua
    lsp.lua_ls.setup({ on_attach = custom_attach })

    lsp.docker_compose_language_service.setup({ on_attach = custom_attach })
end

function mason_lspconfig_setup()
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
        ensure_installed = {
            "bashls",
            "clangd",
            "docker_compose_language_service",
            "gopls",
            "lua_ls",
            "marksman",
            "pyright",
            "rust_analyzer",
        },
        automatic_installation = true,
    })
end

return {
    {
        "neovim/nvim-lspconfig",
        config = lspconfig_setup,
        dependencies = {
            {
                "nvim-telescope/telescope.nvim",
            },
            {
                "ray-x/lsp_signature.nvim",
                config = {
                    toggle_key = "<M-x>",
                },
            },
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = {
                    {
                        "williamboman/mason.nvim",
                        config = true,
                    },
                },
                config = mason_lspconfig_setup,
            },
        },
    },
    {
        "ojroques/nvim-lspfuzzy",
        dependencies = { "junegunn/fzf", "junegunn/fzf.vim" },
        config = true,
    },
}
