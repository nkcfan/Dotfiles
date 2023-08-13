function lspkind_init()
    local symbols = {
        -- Class = '🅒',
        Class = "∴",
        -- Color = '☀',
        -- Color = '⛭',
        Color = "🖌",
        -- Constant = 'π',
        Constant = "𝜋",
        Constructor = "⬡",
        -- Constructor = '⌬',
        -- Constructor = '⎔',
        -- Constructor = '⚙',
        -- Constructor = 'ᲃ',
        Enum = "",
        EnumMember = "",
        Event = "",
        -- Field = '→',
        -- Field = '∴',
        Field = "🠶",
        File = "",
        Folder = "",
        -- Function = 'ƒ',
        Function = "λ",
        Interface = "",
        Keyword = "🗝",
        -- Method = '𝘮',
        Method = "λ",
        Module = "📦",
        -- Operator = '≠',
        Operator = "±",
        -- Property = '::',
        Property = "∷",
        -- Reference = '⌦',
        -- Reference = '⊷',
        -- Reference = '⊶',
        Reference = "⊸",
        Snippet = "",
        -- Snippet = '↲',
        -- Snippet = '♢',
        -- Snippet = '<>',
        -- Snippet = '{}',
        Struct = "",
        -- Text = '#',
        -- Text = '♯',
        -- Text = 'ⅵ',
        Text = "¶",
        -- Text = "𝒯",
        -- Text = "𝓣",
        -- Text = "𐄗",
        TypeParameter = "×",
        Unit = "()",
        -- Value           =
        -- Variable = '𝛼',
        -- Variable = 'χ',
        -- Variable = '𝓧',
        -- Variable = '𝛸',
        Variable = "α",
        -- Variable = '≔',
    }
    -- other symbols that might be useful for something: -- ⊕ † ፨ ᯾ ⁂ ∎ ∹ ☖ ⚐ 🕮 🗈 🗉 🗈 🗉 ⬠  ⬡  ⮺  ⮻ ⯐  ⯒ ⟡ ✐  ✎ ꒾꙳ ꥟ ⤙ ⤚ ⤛ ⤜

    require("lspkind").init({
        -- DEPRECATED (use mode instead): enables text annotations
        --
        -- default: true
        -- with_text = true,

        -- defines how annotations are shown
        -- default: symbol
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = "symbol_text",

        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
        preset = "codicons",

        -- override preset symbols
        --
        -- default: {}
        symbol_map = symbols,
    })
end

return {
    "onsails/lspkind-nvim",
    config = lspkind_init,
}
