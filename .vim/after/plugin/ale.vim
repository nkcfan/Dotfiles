if !exists(':ALEInfo')
    finish
endif

" Disable ALE text highlight in insert mode to help readability
" Note: Leave insert mode by <Esc>, if <C-C> then ALE text highlight will not
" come back
augroup disable_ale_insert
    autocmd!
    autocmd InsertEnter * silent! let g:ale_enabled=0 | call ale#highlight#UpdateHighlights()
    autocmd InsertLeave * silent! let g:ale_enabled=1 | call ale#highlight#UpdateHighlights()
augroup END
