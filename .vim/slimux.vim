" Slimux
let g:slimux_select_from_current_window = 1
" Key mappings for slimux
if !exists('g:slimux_map') | let g:slimux_map = "<M-e>" | endif
execute "nnoremap " . g:slimux_map . g:slimux_map . " :SlimuxREPLSendLine<CR>"
execute "inoremap " . g:slimux_map . g:slimux_map . " <C-O>:SlimuxREPLSendLine<CR>"
" Adapt Slimux to an operator
" Note: a <Plug> is needed to prevent escaping customized key mapping in
" execute normal statements
execute "vnoremap <silent> <Plug>(SlimuxVisual) :<C-U>call SlimuxAdaptor(visualmode(), 1)<CR>"
execute "vmap <silent> " g:slimux_map " <Plug>(SlimuxVisual)"
execute "nnoremap <silent> " g:slimux_map " :set opfunc=SlimuxAdaptor<CR>g@"
function! SlimuxAdaptor(type, ...)
    if a:0  " invoked from visual mode, use '< and '> marks.
        silent execute ":'<,'>SlimuxREPLSendSelection<CR>"
    elseif a:type == 'line'
        silent execute "normal `[V`]\<Plug>(SlimuxVisual)"
    elseif a:type == 'block'
        silent execute "normal `[\<C-V>`]\<Plug>(SlimuxVisual)"
    else
        silent execute "normal `[v`]\<Plug>(SlimuxVisual)"
    endif
endfunction
