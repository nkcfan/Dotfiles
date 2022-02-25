local cmp = require "cmp"
local lspkind = require "lspkind"

cmp.setup {
    mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping.confirm({ select = false }),
    },

    --    the order of your sources matter (by default). That gives them priority
    --    you can configure:
    --        keyword_length
    --        priority
    --        max_item_count
    --        (more?)
    sources = {
        -- Could enable this only for lua, but nvim_lua handles that already.
        { name = "nvim_lua" },

        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 2 },
        { name = "spell", keyword_length = 4 },
    },

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },

    completion = {
        -- completeopt = "menu,menuone,noinsert",
        completeopt = "menu,menuone",
    },

    formatting = {
        format = lspkind.cmp_format {
            menu = {
                buffer = '[buf]',
                nvim_lsp = '[lsp]',
                nvim_lua = '[lua]',
                path = '[path]',
                luasnip = '[snip]',
                spell = '[spl]',
            },
        },
    },

    experimental = {
        native_menu = false,
        ghost_text = false,
    },
}
