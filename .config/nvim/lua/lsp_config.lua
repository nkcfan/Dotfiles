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
lsp.pyright.setup {on_attach = custom_attach}
