call plug#begin('~/.vim/bundle')
" The following are examples of different formats supported.
Plug 'vim-scripts/argtextobj.vim'
Plug 'Valloric/YouCompleteMe', { 'on': 'YcmCompleter' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'mhinz/vim-signify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind'] }
"Plug 'jeaye/color_coded'
"Plug 'vim-syntastic/syntastic'
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'svermeulen/vim-easyclip'
Plug 'epeli/slimux'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-ninja-feet'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'pearofducks/ansible-vim'
Plug 'joshdick/onedark.vim'
" All of your Plugins must be added before the following line
" Initialize plugin system
call plug#end()

set nocompatible
set hidden                    " required by vim-ctrlspace
set path+=**
set wildmenu
set wildmode=longest:full
set encoding=utf-8
set selection=exclusive
" Always show statusline
set laststatus=2
" Show line numbers
set number
" Show invisible char
set list
set listchars=tab:↹\ 
" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" Line wrap
" To insert the elipsis, press ctrl-vu followed by the numeric code for elipsis: 2026
set wrap linebreak
set showbreak=…
" Allows the left and right arrow keys to wrap around lines
set whichwrap+=<,>,h,l,[,]
" Backspace
set backspace=indent,eol,start

" tmux will send xterm-style keys when xterm-keys is on
" ref: http://unix.stackexchange.com/questions/29907/how-to-get-vim-to-work-with-tmux-properly/34723#34723
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <kDel>=\e[3;*~"
endif

" Fix MSYS environment
if has('win32')
"	let &t_AF="\e[38;5;%dm"
"	let &t_AB="\e[48;5;%dm"
endif

" Set mouse in all mode
set mouse+=a
" Fix mouse dragging splitters inside tmux
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" lightline
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ]
      \ }
      \ }

" YouCompleteMe
let g:ycm_extra_conf_globlist = ['~/work/*','/mnt/data[!/]*/*','!~/*']
let g:ycm_autoclose_preview_window_after_completion = 1

" Slimux
let g:slimux_select_from_current_window = 1

" Newbie vim-syntastic/syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Colors
set cursorline
syntax on
colorscheme onedark

" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Key naming
execute "set <M-E>=\ee"
execute "set <M-I>=\ei"
execute "set <M-O>=\eo"
execute "set <M-V>=\ev"
execute "set <C-Home>=\e[1;5H"
execute "set <C-End>=\e[1;5F"

" Key mappings in normal mode
nnoremap <M-I> :YcmCompleter GoTo<CR>
" Naviaget Back
nnoremap <M-O> <C-O>
" Select text just pasted
" ref: http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
nnoremap <C-Home> gg
nnoremap <C-End> G
nnoremap <C-S> :w<CR>
nnoremap <C-W> :bd<CR>
nnoremap <expr><C-Left> "b"
nnoremap <expr><C-Right> "w"
nnoremap <expr><BS> "X"
" C-BS
nnoremap <expr><C-H> "\"_db"
" C-Del
nnoremap <expr><C-kDel> "\"_dw"
nnoremap <expr><C-X> "dd"
nnoremap <C-P><C-P> :CtrlPBuffer<CR>

" Key mappings in insert mode
inoremap <C-kDel> <C-O>"_dw
inoremap <M-I> <C-O>:YcmCompleter GoTo<CR>
inoremap <M-O> <C-O><C-O>
inoremap <C-S> <C-O>:w<CR>
inoremap <C-P> <C-O>:CtrlP<CR>
inoremap <C-P><C-P> <C-O>:CtrlPBuffer<CR>

" Key mappings in command-line mode
" C-BS
noremap! <C-H> <C-W>

" Commentary
xmap <C-Q>  <Plug>Commentary
nmap <C-Q>  <Plug>Commentary
omap <C-Q>  <Plug>Commentary
nmap <C-Q><C-Q> <Plug>CommentaryLine

" Natual search and replace
" ref: http://vim.wikia.com/wiki/Copy_or_change_search_hit
" ref: https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" Make a simple "search" text object.
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" Key mappings for slime
if !exists('g:slimux_map') | let g:slimux_map = "\<M-E>" | endif
execute "nnoremap " . g:slimux_map . g:slimux_map . " :SlimuxREPLSendLine<CR>"
execute "inoremap " . g:slimux_map . g:slimux_map . " <C-O>:SlimuxREPLSendLine<CR>"
" Adapt Slimux to an operator
execute "nnoremap <silent> " g:slimux_map " :set opfunc=SlimuxAdaptor<CR>g@"
execute "vnoremap <silent> " g:slimux_map " :<C-U>call SlimuxAdaptor(visualmode(), 1)<CR>"
function! SlimuxAdaptor(type, ...)
    if a:0  " invoked from visual mode, use '< and '> marks.
        silent execute ":'<,'>SlimuxREPLSendSelection<CR>"
    elseif a:type == 'line'
        silent execute "normal `[V`]" g:slimux_map
    elseif a:type == 'block'
        silent execute "normal `[\<C-V>`]" g:slimux_map
    else
        silent execute "normal `[v`]" g:slimux_map
    endif
endfunction

