set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

set winblend=5
set pumblend=5

if has('nvim-0.5.0')
    lua <<EOF
        require'nvim-treesitter.configs'.setup {
            ensure_installed = {
                "bash",
                "cpp",
                "go",
                "javascript",
                "json",
                "lua",
                "python",
                "yaml",
            },  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
            highlight = {
                enable = true,  -- false will disable the whole extension
                disable = {},  -- list of language that will be disabled
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "vii",
                    scope_incremental = "ii",
                    node_incremental = "<CR>",
                    node_decremental = "<BS>",
                },
            },
            refactor = {
                highlight_definitions = { enable = true },
                highlight_current_scope = { enable = false },
            },
        }
EOF
endif
