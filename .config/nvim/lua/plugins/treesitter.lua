local foldmethod_backups = {}
local foldexpr_backups = {}

function treesitter_setup()
    local define_modules = require("nvim-treesitter").define_modules
    local query = require("nvim-treesitter.query")

    -- folding module
    -- ref: https://github.com/nvim-treesitter/nvim-treesitter/issues/475#issuecomment-748532035
    define_modules({
        folding = {
            enable = true,
            attach = function(bufnr)
                -- Fold settings are actually window based...
                foldmethod_backups[bufnr] = vim.wo.foldmethod
                foldexpr_backups[bufnr] = vim.wo.foldexpr
                vim.wo.foldmethod = "expr"
                vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
            end,
            detach = function(bufnr)
                vim.wo.foldmethod = foldmethod_backups[bufnr]
                vim.wo.foldexpr = foldexpr_backups[bufnr]
                foldmethod_backups[bufnr] = nil
                foldexpr_backups[bufnr] = nil
            end,
            is_supported = query.has_folds,
        },
    })

    require("nvim-treesitter.configs").setup({
        auto_install = true,
        folding,
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = {}, -- list of language that will be disabled
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "vii",
                scope_incremental = "ii",
                node_incremental = "<CR>",
                node_decremental = "<S-CR>",
            },
        },
        refactor = {
            highlight_definitions = { enable = true },
            highlight_current_scope = { enable = false },
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["cc"] = "@comment.outer",
                    ["ss"] = "@statement.outer",
                    -- Or you can define your own textobjects like this
                    -- ["iF"] = {
                    --     python = "(function_definition) @function",
                    --     cpp = "(function_definition) @function",
                    --     c = "(function_definition) @function",
                    --     java = "(method_declaration) @function"
                    -- }
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<LocalLeader><LocalLeader>a"] = "@parameter.inner",
                    ["<LocalLeader><LocalLeader>s"] = "@statement.outer",
                },
                swap_previous = {
                    ["<LocalLeader><LocalLeader>A"] = "@parameter.inner",
                    ["<LocalLeader><LocalLeader>S"] = "@statement.outer",
                },
            },
            move = {
                enable = true,
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]]"] = "@class.outer",
                    ["]a"] = "@parameter.inner",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]["] = "@class.outer",
                    ["]A"] = "@parameter.inner",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[["] = "@class.outer",
                    ["[a"] = "@parameter.inner",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[]"] = "@class.outer",
                    ["[A"] = "@parameter.inner",
                },
            },
        },
    })
    vim.api.nvim_set_keymap("n", "<LocalLeader>th", "<cmd>TSBufToggle highlight<CR>", {})

    function GitFileStatus()
        local file = vim.fn.expand("%")
        if file == "" then
            return ""
        end
        local filestatus = vim.fn.system("git status --porcelain " .. vim.fn.shellescape(file))
        return string.sub(filestatus, 1, 2)
    end

    function RespectGitFileStatus()
        if GitFileStatus() == "UU" then
            if exists(':TSBufDisable') then
                execute 'TSBufDisable highlight'
            end
            vim.diagnostic.disable(0, nil)
        end
    end

    local augroup = vim.api.nvim_create_augroup("respectgit", {})
    vim.api.nvim_create_autocmd({"BufNewFile", "BufFilePre", "BufRead"}, {
        pattern = "*",
        callback = RespectGitFileStatus,
        group = augroup,
    })
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        cond = vim.fn.executable("tree-sitter"),
        build = ":TSUpdate", -- We recommend updating the parsers on update
        config = treesitter_setup,
        dependencies = {
            {
                -- lsp won't start if this is removed
                -- ref: https://www.reddit.com/r/neovim/comments/14cikep/on_nightly_my_lsp_is_not_starting_automatically/
                "neovim/nvim-lspconfig"
            },
            { "nvim-treesitter/nvim-treesitter-refactor" },
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
        },
    },
}
