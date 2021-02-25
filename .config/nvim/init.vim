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
    lua require('treesitter_config')
    nnoremap <LocalLeader>th                    :TSBufToggle highlight<CR>

    lua require('lsp_config')
    lua require('telescope_config')
    nnoremap <silent> z=                        :Telescope spell_suggest<CR>
    nnoremap <silent> <C-S-PageDown>            :Telescope loclist<CR>
    nnoremap <silent> <S-PageDown>              :Telescope quickfix<CR>

    lua require('completion_config')
    " Use completion-nvim in every buffer
    autocmd BufEnter * lua require'completion'.on_attach()
endif
