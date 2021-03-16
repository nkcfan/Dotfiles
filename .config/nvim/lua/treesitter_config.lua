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
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    folding,
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {} -- list of language that will be disabled
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
                ["iF"] = {
                    python = "(function_definition) @function",
                    cpp = "(function_definition) @function",
                    c = "(function_definition) @function",
                    java = "(method_declaration) @function"
                }
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
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    }
}
