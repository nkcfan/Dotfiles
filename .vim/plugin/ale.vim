" ALE config
" linters
let g:ale_linters = {
            \ 'text': ['alex'],
            \}

if !has('nvim-0.5.0')
    let g:ale_lint_on_text_changed = 'never'
    " Note: Mouse move triggers mess characters when enabling balloons together with coc.nvim coc-references window open
    " Note: seems working well with coc-fzf, only in vim
    let g:ale_set_balloons=1
    let g:ale_floating_preview=1
    let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let g:ale_enabled=1

    " virtualtext support
    let g:ale_virtualtext_cursor = 1
    let g:ale_virtualtext_prefix = '    ■ '

    let g:ale_sh_bashate_options = '-i E006'
endif
