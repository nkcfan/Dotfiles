" slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
"let g:slime_target = "vimterminal"
"let g:slime_target = "neovim"
let g:slime_no_mappings = 1
" Key mappings for slime
if !exists('g:slime_map') | let g:slime_map = "<M-e>" | endif
execute "nnoremap " . g:slime_map . g:slime_map . " :SlimeSendCurrentLine<CR>"
execute "inoremap " . g:slime_map . g:slime_map . " <C-O>:SlimeSendCurrentLine<CR>"
execute "nnoremap " . g:slime_map               . " :set opfunc=slime#send_op<cr>g@"
execute "xmap "     . g:slime_map               . " <Plug>SlimeRegionSend"
