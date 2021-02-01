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
if has('win32')
    let $FZF_DEFAULT_COMMAND = '( rg --files --path-separator "//" & git ls-files ) | sort /unique'
else
    let $FZF_DEFAULT_COMMAND = '{ rg --files --hidden & git ls-files; } | sort -u'
endif
