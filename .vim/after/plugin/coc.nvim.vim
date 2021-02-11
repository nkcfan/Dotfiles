" coc.nvim
if !exists('*CocAction')
    finish
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> vv :<C-u>call CocAction('jumpDefinition')<CR>
nmap <silent> gD :<C-u>call CocAction('jumpDeclaration')<CR>
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> rr <Plug>(coc-references)
" Remap for do codeAction of current line
nmap <leader>ra  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>rf  <Plug>(coc-fix-current)
" CoC Settings
let g:coc_global_extensions = [
            \ 'coc-git',
            \ 'coc-go',
            \ 'coc-json',
            \ 'coc-pyright',
            \ ]
" Snippet expand and jump
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if index(['vim','help'], &filetype) >= 0
    execute 'h '.expand('<cword>')
  elseif coc#rpc#ready()
    call CocActionAsync('doHover')
  elseif g:ale_enabled
    call ale#hover#ShowAtCursor()
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
