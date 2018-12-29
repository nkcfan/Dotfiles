function! EasyClip#Yank#OnYanksChanged()
    if $TMUX != ''
        call system("tmux load-buffer -", EasyClip#GetCurrentYank())
    endif
    call EasyClip#Yank#SyncNumberedRegisters()
    call EasyClip#Shared#SaveToFileIfDirty()
endfunction
