function! OperatorFuncYankS(type)
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
endfunction

" Replace current word or current selection, following by
" 1. 'n' to next occurance
" 2. '.' to repeat the replacement again
" Useful for replacing a few instances of the term (comparable to multiple cursors).
" nnoremap <silent> <Leader>ciw   :let @/='\<'.expand('<cword>').'\>'<CR>cgn
" xnoremap <silent> <Leader>c     "sy:let @/=@s<CR>cgn
vnoremap <silent> <Plug>(SearchableChange)      "sy:<C-U>call SearchableChangeAdapter(visualmode(), 1)<CR>
vmap <silent> <Leader>c                         <Plug>(SearchableChange)
nnoremap <Leader>c                              :set opfunc=SearchableChangeAdapter<CR>g@
nmap <Leader>cc                                 viw<Leader>c
function! SearchableChangeAdapter(type, ...)
    if a:0  " invoked from visual mode, use '< and '> marks.
        let @/ = getreg('s')
        call feedkeys("cgn")
        return
    endif
    call OperatorFuncYankS(a:type)
    call SearchableChangeAdapter(visualmode(), 1)
endfunction

" Find current word or current selection
vnoremap <silent> <Plug>(JustFind)              "sy:<C-U>call JustFindAdapter(visualmode(), 1)<CR>
vmap <silent> <C-F>                             <Plug>(JustFind)
nnoremap <C-F>                                  :set opfunc=JustFindAdapter<CR>g@
nmap <C-F><C-F>                                 viw<C-F>
function! JustFindAdapter(type, ...)
    if a:0  " invoked from visual mode, use '< and '> marks.
        " Escape register for \V grep to prevent special char of regex
        let @s = escape(getreg('s'), '/\')
        call feedkeys(":lvimgrep /\\V" . @s . "/gj %\<Left>\<Left>\<Left>\<Left>\<Left>")
        " call feedkeys(':BLines ' . @s)
        return
    endif
    call OperatorFuncYankS(a:type)
    call JustFindAdapter(visualmode(), 1)
endfunction

" Search for visually selected text, and select the found text
" ref: https://vim.fandom.com/wiki/Search_for_visually_selected_text
xnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>vgn
xnoremap # y?\V<C-R>=escape(@",'/\')<CR><CR>vgn
