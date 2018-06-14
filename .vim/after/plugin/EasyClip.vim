function! EasyClip#Yank#OnYanksChanged()
    if $TMUX != ''
        call system("tmux load-buffer -", EasyClip#GetCurrentYank())
    endif
    call EasyClip#Yank#SyncNumberedRegisters()
    call EasyClip#Shared#SaveToFileIfDirty()
endfunction

" Dont' black hole x/X
function! EasyClip#BlackHole#AddDeleteBindings()
    let bindings =
    \ [
    \   ['d', '"_d', 'nx'],
    \   ['dd', '"_dd', 'n'],
    \   ['dD', '0"_d$', 'n'],
    \   ['D', '"_D', 'nx'],
    \ ]
    for binding in bindings
        call call("EasyClip#AddWeakMapping", binding)
    endfor
endfunction

call EasyClip#BlackHole#AddDeleteBindings()
