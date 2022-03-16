local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

cmp.setup {
    mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.confirm({ select = false }) then
                -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            elseif luasnip.jumpable() then
                luasnip.jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
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
            luasnip.lsp_expand(args.body)
        end,
    },

    documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },

    completion = {
        -- completeopt = "menu,menuone,noinsert",
        completeopt = "menu,menuone,noselect",
    },

    formatting = {
        format = lspkind.cmp_format {
            menu = {
                buffer = '[buf]',
                nvim_lsp = '[lsp]',
                nvim_lua = '[lua]',
                path = '[path]',
                luasnip = '[snip]',
                -- spell = '[spl]',
            },
        },
    },

    matching = {
        disallow_prefix_unmatching = true,
    },

    experimental = {
        native_menu = false,
        ghost_text = false,
    },
}
