if !exists(':FZF')
    finish
endif

" Starting fzf in a popup window
" Required:
" - width [float range [0 ~ 1]]
" - height [float range [0 ~ 1]]
" Optional:
" - xoffset [float default 0.5 range [0 ~ 1]]
" - yoffset [float default 0.5 range [0 ~ 1]]
" - highlight [string default 'Comment']: Highlight group for border
" - border [string default 'rounded']: Border style
"   - 'rounded' / 'sharp' / 'horizontal' / 'vertical' / 'top' / 'bottom' / 'left' / 'right'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" <M-a> to select all in fzf window
" Note: this is required because no default binding
let $FZF_DEFAULT_OPTS = '--bind alt-a:toggle-all'
" Tell FZF to use RG - so we can ignore files, but keep git controlled files
if empty($FZF_DEFAULT_COMMAND)
    " Note: because cmd will not run .bashrc, there is no FZF_DEFAULT_COMMAND env var
    if has('win32')
        let $FZF_DEFAULT_COMMAND = expand('~/bin/ripgrep_git.cmd')
    endif
endif

" Insert mode completion
" imap <C-X><C-K> <plug>(fzf-complete-word)
imap <C-X><C-F> <plug>(fzf-complete-path)
imap <C-X><C-J> <plug>(fzf-complete-file-ag)
imap <C-X><C-L> <plug>(fzf-complete-line)

" Mapping selecting mappings
nmap <Leader><tab> <plug>(fzf-maps-n)
xmap <Leader><tab> <plug>(fzf-maps-x)
omap <Leader><tab> <plug>(fzf-maps-o)

" fzf_tags
nmap <C-]> <Plug>(fzf_tags)
noreabbrev <expr> ts getcmdtype() == ":" && getcmdline() == 'ts' ? 'FZFTselect' : 'ts'
