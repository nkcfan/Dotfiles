set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

set winblend=5
set pumblend=5

" highlightedyank
augroup highlight_yank
    autocmd!
    au TextYankPost * lua vim.highlight.on_yank()
augroup END

if has('nvim-0.5.0')
    lua <<EOF
require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "bash",
        "cpp",
        "go",
        "javascript",
        "json",
        "lua",
        "python",
        "yaml"
    }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
        }
    }
}
EOF
endif
