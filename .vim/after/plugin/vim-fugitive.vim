if !exists(':GBrowse')
    finish
endif

function! s:onGitFile() abort
    if !empty(FugitiveGitDir()) && &buftype == '' && @% != ''
        call feedkeys(":Git! difftool | cclose | echon '' \<CR>")
    endif
endfunction

" Feed diff hunks to quickfix
augroup fugitive_quickfix
    autocmd!
    " autocmd User FugitiveChanged if &buftype == '' | call feedkeys(":Git! difftool | cclose | echon '' \<CR>") | endif
    autocmd BufNewFile,BufReadPost *.* call s:onGitFile()
augroup END

call s:onGitFile()
