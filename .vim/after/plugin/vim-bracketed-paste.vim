" Disable bracketed-paste in normal mode, operator pending mode and terminal mode
nunmap <f28>
ounmap <f28>
nnoremap <f29> <nop>
onoremap <f29> <nop>

if has('terminal')
    tnoremap <f28> <nop>
    tnoremap <f29> <nop>
endif
