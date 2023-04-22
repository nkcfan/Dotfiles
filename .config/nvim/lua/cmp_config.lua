local cmp = require("cmp")
local types = require('cmp.types')
local lspkind = require("lspkind")
local luasnip = require("luasnip")

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-Y>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        -- Define a manual toggle
        -- Note: i_CTRL-E is overridden
        ["<C-E>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.mapping.abort()(fallback)
            else
                cmp.mapping.complete()()
            end
        end, { "i", "s" }),
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
    }),

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

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    completion = {
        -- completeopt = "menu,menuone,noinsert",
        completeopt = "menu,menuone,noselect",
    },

    formatting = {
        format = lspkind.cmp_format({
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[lsp]",
                nvim_lua = "[lua]",
                path = "[path]",
                luasnip = "[snip]",
                -- spell = '[spl]',
            },
        }),
    },

    matching = {
        disallow_prefix_unmatching = true,
    },

    experimental = {
        native_menu = false,
        ghost_text = false,
    },
})
-- `/` cmdline setup.
cmdline_mapping = {
    -- Define a manual toggle
    ["<C-E>"] = {
        c = function(fallback)
            if cmp.visible() then
                cmp.mapping.close()(fallback)
            else
                cmp.mapping.complete()(fallback)
            end
        end,
    },
    -- ["<Tab>"] = {
    --     c = function(fallback)
    --         fallback()
    --     end,
    -- },
    -- ["<S-Tab>"] = {
    --     c = function(fallback)
    --         fallback()
    --     end,
    -- },
    ["<Down>"] = {
        c = function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end,
    },
    ["<Up>"] = {
        c = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end,
    },
}
-- -- `/` cmdline setup.
-- cmp.setup.cmdline("/", {
--     mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
--     completion = {
--         autocomplete = false,
--     },
--     sources = {
--         { name = "buffer" },
--     },
-- })
-- -- `:` cmdline setup.
-- cmp.setup.cmdline(":", {
--     mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
--     completion = {
--         autocomplete = false,
--     },
--     sources = cmp.config.sources({
--         { name = "path" },
--     }, {
--         { name = "cmdline" },
--     }),
-- })

