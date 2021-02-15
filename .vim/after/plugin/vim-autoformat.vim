if !exists(':Autoformat')
    finish
end

noremap <Leader>fm                          :Autoformat<CR>
vnoremap <Leader>fi                         :Autoformat<Space>
