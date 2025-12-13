if !exists(':Neoformat')
    finish
endif

noremap <Leader>fm                          :Neoformat<CR>
vnoremap <Leader>fi                         :Neoformat!<Space>
