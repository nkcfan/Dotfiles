if !exists(':Neoformat')
    finish
end

noremap <Leader>fm                          :Neoformat<CR>
vnoremap <Leader>fi                         :Neoformat!<Space>
