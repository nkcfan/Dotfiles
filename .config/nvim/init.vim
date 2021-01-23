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
        }
EOF
endif
