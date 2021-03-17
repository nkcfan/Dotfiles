" Move quickly in loclist from current line
nmap <silent> <expr> <C-S-Up>               ':<C-U>' . v:count . 'labove<CR>:call MaybeMiddle()<CR>'
nmap <silent> <expr> <C-S-Down>             ':<C-U>' . v:count . 'lbelow<CR>:call MaybeMiddle()<CR>'
nnoremap <silent> <C-S-Left>                :lolder<CR>
nnoremap <silent> <C-S-Right>               :lnewer<CR>
nnoremap <silent> <C-S-PageUp>              :call ToggleLocList()<CR>

" Move quickly in quickfix list from current line
nmap <silent> <expr> <S-Down>               ':<C-U>' . v:count . 'cbelow<CR>:call MaybeMiddle()<CR>'
nmap <silent> <expr> <S-Up>                 ':<C-U>' . v:count . 'cabove<CR>:call MaybeMiddle()<CR>'
nnoremap <silent> <S-Left>                  :colder<CR>
nnoremap <silent> <S-Right>                 :cnewer<CR>
nnoremap <silent> <S-PageUp>                :call ToggleQuickFix()<CR>

" QuickFix/LocList automation
" ref: https://vi.stackexchange.com/a/16807/27252
augroup quickfix_nofocus
    autocmd!
    autocmd QuickFixCmdPre * let g:mybufname=bufname('%')
    autocmd QuickFixCmdPost lvimgrep botright lopen | exec bufwinnr(g:mybufname) . 'wincmd w'
    autocmd QuitPre * lclose | cclose
augroup END

" ref: https://stackoverflow.com/a/63162084/2514803
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix')) && empty(filter(getwininfo(), 'v:val.loclist'))
        let g:mybufname=bufname('%')
        copen
        exec bufwinnr(g:mybufname) . 'wincmd w'
    else
        cclose
        lclose
        pclose
    endif
endfunction
function! ToggleLocList()
    if empty(filter(getwininfo(), 'v:val.quickfix')) && empty(filter(getwininfo(), 'v:val.loclist'))
        let g:mybufname=bufname('%')
        lopen
        exec bufwinnr(g:mybufname) . 'wincmd w'
    else
        cclose
        lclose
        pclose
    endif
endfunction
