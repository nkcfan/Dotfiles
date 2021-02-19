" special char ref: https://github.com/source-foundry/Hack/issues/124
let g:lightline = {
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste', 'gutentags', 'cocstatus' ],
      \     [ 'readonly', 'filename', 'modified' ],
      \     [ 'fugitive' ]
      \   ],
      \   'right': [
      \     [ 'lineinfo' ],
      \     [ 'percent', 'indicator' ],
      \     [ 'fileformat', 'fileencoding', 'filetype' ],
      \     [ 'linter_checking', 'linter_infos', 'linter_warnings', 'linter_errors', 'linter_ok' ],
      \   ],
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \   'gutentags': 'LightlineGutentags',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'modified': 'LightlineModified',
      \   'cocstatus': 'LightlineCocStatus',
      \   'blame': 'LightlineGitBlame',
      \   'indicator': 'LineNoIndicator',
      \ },
      \ }

" Use vim colors in lightline.vim
let g:lightline.colorscheme = g:colors_name
augroup LightlineOnColorScheme
  autocmd!
  autocmd ColorScheme * silent! let g:lightline.colorscheme = g:colors_name
  " autocmd VimLeave * !tmux source-file ~/.tmux.conf
augroup END

if !exists('*nvim_buf_set_virtual_text')
    call add(g:lightline.active.right, ['blame'])
endif

let g:lightline.component_expand = {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_infos': 'lightline#ale#infos',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \   'linter_checking': 'right',
      \   'linter_infos': 'right',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'right',
      \ }
let g:lightline#ale#indicator_checking = ''
let g:lightline#ale#indicator_infos = "🛈 "
let g:lightline#ale#indicator_warnings = "! "
let g:lightline#ale#indicator_errors = "✘ "
let g:lightline#ale#indicator_ok = "✓"

augroup LightlineOnChanges
  autocmd!
  autocmd User ALEFixPre   call lightline#update()
  autocmd User ALEFixPost  call lightline#update()
  autocmd User ALELintPre  call lightline#update()
  autocmd User ALELintPost call lightline#update()
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
  autocmd User CocGitStatusChange call lightline#update()
  autocmd User LspDiagnosticsChanged call lightline#update()
augroup end

" gutentags
function! LightlineGutentags() abort
  if exists('*gutentags#statusline')
    return gutentags#statusline()
  else
    return ''
  endif
endfunction

" coc.nvim
function! LightlineCocStatus() abort
  if exists('*coc#status')
    return coc#status()
  else
    return ''
  endif
endfunction

" coc-git
function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : '' "&modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? "\ue0a2" : ''
endfunction

function! LightlineFilename()
  "let fname = expand('%:t')
  let fname = fnamemodify(expand("%"), ":~:.")
  " Distinguish the current buffer is location list or quickfix
  " ref: https://stackoverflow.com/a/53491991/2514803
  if &ft == 'qf'
    if getwininfo(win_getid())[0]['loclist'] == 1
      return '<C-S-PageUp> to close loclist'
    else
      return '<S-PageUp> to close quickfix'
    endif
  else
    return  &ft == 'tagbar' ? '' :
          \ &ft == 'qf' ? '<S-Up> to close quickfix' :
          \ &ft == 'fugitiveblame' ? '' :
          \ fname =~ '__Gundo\|NERD_tree' ? '' :
          \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
          \ &ft == 'unite' ? unite#get_status_string() :
          \ &ft == 'vimshell' ? vimshell#get_status_string() :
          \ ('' != fname ? fname : '[No Name]')
  endif
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && !exists('*fugitive')
      let mark = "\ue0a0"  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
let g:line_no_indicator_chars = ['⎺', '⎻', '─', '⎼', '⎽']
