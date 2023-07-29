local define_modules = require("nvim-treesitter").define_modules
local query = require("nvim-treesitter.query")

local foldmethod_backups = {}
local foldexpr_backups = {}

-- folding module
-- ref: https://github.com/nvim-treesitter/nvim-treesitter/issues/475#issuecomment-748532035
define_modules(
    {
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
            is_supported = query.has_folds
        }
    }
)

require "nvim-treesitter.configs".setup {
    ensure_installed = { "ocaml_interface", "fortran", "python", "c_sharp",
        "gomod", "json5", "gowork", "todotxt", "graphql", "typescript", "ruby",
        "perl", "supercollider", "fish", "slint", "php", "haskell", "java",
        "hjson", "kotlin", "tlaplus", "regex", "julia", "llvm", "toml", "css",
        "scss", "prisma", "pug", "rasi", "vue", "foam", "norg", "jsonc", "gleam",
        "cpp", "elm", "javascript", "yaml", "eex", "yang", "heex", "lalrpop",
        "ninja", "vala", "tsx", "nix", "hcl", "cooklang", "glimmer", "solidity",
        "verilog", "rst", "latex", "json", "vim", "teal", "elvish", "markdown",
        "ql", "astro", "hack", "go", "wgsl", "pascal", "make", "http", "scheme",
        "hocon", "pioasm", "vimdoc", "lua", "cmake", "jsdoc", "zig", "ocaml", "rego",
        "sparql", "beancount", "r", "gdscript", "clojure", "svelte", "devicetree",
        "commonlisp", "turtle", "query", "comment", "cuda", "phpdoc", "d",
        "fennel", "dart", "scala", "glsl", "html", "dockerfile", "bash", "c",
        "dot", "erlang", "elixir", "rust", "surface", "fusion", "bibtex",
        "ocamllex", "ledger" }, -- one of "all" or a list of languages
    folding,
    context_commentstring = {
        enable = true
    },
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
            node_decremental = "<S-CR>"
        }
    },
    refactor = {
        highlight_definitions = {enable = true},
        highlight_current_scope = {enable = false}
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
            }
        },
        swap = {
            enable = true,
            swap_next = {
                ["<LocalLeader><LocalLeader>a"] = "@parameter.inner",
                ["<LocalLeader><LocalLeader>s"] = "@statement.outer"
            },
            swap_previous = {
                ["<LocalLeader><LocalLeader>A"] = "@parameter.inner",
                ["<LocalLeader><LocalLeader>S"] = "@statement.outer"
            }
        },
        move = {
            enable = true,
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
                ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
                ["]C"] = "@class.outer",
                ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
                ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[C"] = "@class.outer",
                ["[A"] = "@parameter.inner",
            },
        },
    }
}

vim.api.nvim_set_keymap('n', '<LocalLeader>th', '<cmd>TSBufToggle highlight<CR>', {})
