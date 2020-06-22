" Replace current word or current selection, following by
" 1. 'n' to next occurance
" 2. '.' to repeat the replacement again
" Useful for replacing a few instances of the term (comparable to multiple cursors).
" nnoremap <silent> <leader>ciw   :let @/='\<'.expand('<cword>').'\>'<CR>cgn
" xnoremap <silent> <leader>c     "sy:let @/=@s<CR>cgn
vnoremap <silent> <Plug>(SearchableChange)  "sy:<C-U>call SearchableChangeAdapter(visualmode(), 1)<CR>
vmap <silent> <leader>c <Plug>(SearchableChange)
nnoremap <leader>c                           :set opfunc=SearchableChangeAdapter<CR>g@
function! SearchableChangeAdapter(type, ...)
    if a:0  " invoked from visual mode, use '< and '> marks.
        let @/ = getreg('s')
        call feedkeys("cgn")
        return
    endif

    let sel_save = &selection
    let &selection = "inclusive"
    if a:type == 'line'
        silent execute 'normal! `[V`]"sy'
    elseif a:type == 'block'
        silent execute 'normal! `[\<C-V>`]"sy'
    else
        silent execute 'normal! `[v`]"sy'
    endif
    let &selection = sel_save
    call SearchableChangeAdapter(visualmode(), 1)
endfunction

" Search for visually selected text, and select the found text
" ref: https://vim.fandom.com/wiki/Search_for_visually_selected_text
xnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>vgn
xnoremap # y?\V<C-R>=escape(@",'/\')<CR><CR>vgn
