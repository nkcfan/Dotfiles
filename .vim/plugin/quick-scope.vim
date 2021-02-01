" quick-scope
let g:qs_second_highlight=0
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" Note: Customize colors before you set colorscheme
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary cterm=underline gui=underline
  autocmd ColorScheme * highlight QuickScopeSecondary cterm=underline gui=underline
augroup END
