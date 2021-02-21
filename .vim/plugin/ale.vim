" ALE config
let g:ale_lint_on_text_changed = 'never'
" Note: Mouse move triggers mess characters when enabling balloons together with coc.nvim coc-references window open
" Note: seems working well with coc-fzf, only in vim
let g:ale_set_balloons=1
let g:ale_floating_preview=1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_enabled=1

" virtualtext support
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '    ■ '

" linters
let g:ale_linters = {
            \ 'text': ['alex'],
            \}

let g:ale_sh_bashate_options = '-i E006'
" Disable ALE text highlight in insert mode to help readability
" Note: Leave insert mode by <Esc>, if <C-C> then ALE text highlight will not
" come back
augroup disable_ale_insert
    autocmd!
    autocmd InsertEnter * silent! let g:ale_enabled=0 | call ale#highlight#UpdateHighlights()
    autocmd InsertLeave * silent! let g:ale_enabled=1 | call ale#highlight#UpdateHighlights()
augroup END
