if !exists("g:loaded_bracketed_paste")
    finish
endif

" Disable bracketed-paste in normal mode and operator pending mode
silent! nunmap <f28>
silent! ounmap <f28>
nnoremap <f29> <nop>
onoremap <f29> <nop>
