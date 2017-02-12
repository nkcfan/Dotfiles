set nocompatible              " be iMproved, required
set hidden                    " required by vim-ctrlspace
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin from http://vim-scripts.org/vim/scripts.html
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'mhinz/vim-signify'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'rdnetto/YCM-Generator'
"Plugin 'jeaye/color_coded'
"Plugin 'vim-syntastic/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'haya14busa/incsearch.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-sleuth'
Plugin 'ConradIrwin/vim-bracketed-paste'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set path+=**
set wildmenu
set encoding=utf-8
" Always show statusline
set laststatus=2
" Show line numbers
set number
" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
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

" CtrlP
let g:ctrlp_match_window = 'top,order:ttb'

" YouCompleteMe
let g:ycm_extra_conf_globlist = ['~/work/*','/mnt/data[!/]*/*','!~/*']

" Newbie vim-syntastic/syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Colors
syntax on
colorscheme pablo
set cursorline
hi CursorLine cterm=NONE ctermbg=darkgray

" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Key naming
execute "set <M-I>=\ei"
execute "set <M-O>=\eo"
execute "set <C-Left>=\e[D"
execute "set <C-Right>=\e[C"
execute "set <C-Home>=\e[1;5H"
execute "set <C-End>=\e[1;5F"
execute "set <S-Up>=\e[1;2A"
execute "set <S-Down>=\e[1;2B"
execute "set <S-Left>=\e[1;2D"
execute "set <S-Right>=\e[1;2C"


" Key mappings in normal mode
nnoremap <M-I> :YcmCompleter GoTo<CR>
" Naviaget Back
nnoremap <M-O> <C-O>
nnoremap <C-Home> gg
nnoremap <C-End> G
nnoremap <C-S> :w<CR>
nnoremap <expr><C-Left> "b"
nnoremap <expr><C-Right> "w"
nnoremap <expr><BS> "X"
nnoremap <expr><C-H> "db"
nnoremap <expr><C-X> "dd"
nnoremap <C-P><C-P> :CtrlPBuffer<CR>

" Key mappings in insert mode
inoremap <C-S> <Esc>:w<CR>i

" Key mappings in command-line mode
" C-BS
noremap! <C-H> <C-W>

" Key mapping for natural copy and paste :)
vnoremap <C-C> "+yi
vnoremap <C-X> "+c
vnoremap <C-V> c<ESC>"+p
inoremap <C-V> <C-r><C-o>+

" Key mapping for natual selecting :)
nnoremap <S-Up> v<Up>
nnoremap <S-Down> v<Down>
nnoremap <S-Left> v<Left>
nnoremap <S-Right> v<Right>
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>
inoremap <S-Up> <Esc>v<Up>
inoremap <S-Down> <Esc>v<Down>
inoremap <S-Left> <Esc>v<Left>
inoremap <S-Right> <Esc>v<Right>

let g:prev_register = @0
function! Idle()
   if g:prev_register != @0
      let g:prev_register = @0
      if $TMUX != ''
         call system("tmux load-buffer -", @0)
      endif
      echo "register copied"
   endif
endfunction
autocmd CursorHold * call Idle()

