" vim-which-key
nnoremap <silent><expr> <Leader>            ":<C-U>WhichKey '" . get(g:,"mapleader","\\") . "'<CR>"
nnoremap <silent><expr> <LocalLeader>       ":<C-U>WhichKey '" . get(g:,"maplocalleader","\\") . "'<CR>"
nnoremap <silent> g                         :<C-U>WhichKey 'g'<CR>
" Show vim-which-key in fugitive filetype
augroup fugitive_which_key
    autocmd!
    " Note: it does not support vim default mappings because they are not in nmap
    autocmd FileType fugitive
        \ nnoremap <buffer><silent><expr> c     ":<C-U>WhichKey 'c'<CR>" |
        \ nnoremap <buffer><silent><expr> d     ":<C-U>WhichKey 'd'<CR>" |
        \ nnoremap <buffer><silent><expr> r     ":<C-U>WhichKey 'r'<CR>" |
        \ nnoremap <buffer><silent><expr> [     ":<C-U>WhichKey '['<CR>" |
        \ nnoremap <buffer><silent><expr> ]     ":<C-U>WhichKey 'd'<CR>" |
        \ nnoremap <buffer><silent><expr> g     ":<C-U>WhichKey 'g'<CR>" |
        " EOL
augroup END
let g:which_key_use_floating_win = 0
let g:which_key_fallback_to_native_key = 1
