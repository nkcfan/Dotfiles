return {
    {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
        config = function()
            snip = require("luasnip")
            vscode = require("luasnip.loaders.from_vscode")

            vscode.load()
        end,
    },
}
