if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
" The following are examples of different formats supported.
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Valloric/YouCompleteMe', { 'on': 'YcmCompleter' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'mhinz/vim-signify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind'] }
"Plug 'jeaye/color_coded'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'shime/vim-livedown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'svermeulen/vim-cutlass'
Plug 'epeli/slimux'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-ninja-feet'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'pearofducks/ansible-vim'
Plug 'joshdick/onedark.vim'
Plug 'wsdjeg/vim-fetch'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Shougo/echodoc.vim'
Plug 'mbbill/echofunc'
" All of your Plugins must be added before the following line
" Initialize plugin system
call plug#end()

source ~/.vim/lightline.vim

" Detect filetype
autocmd BufRead,BufNewFile */ansible/{**/,}*.yml set filetype=yaml.ansible
autocmd FileType gitcommit setlocal spell
autocmd FileType help noremap <buffer> q :q<cr>

set nocompatible
set hidden                    " required by vim-ctrlspace
set path+=**
set wildmenu
set wildmode=longest:full,full
set encoding=utf-8
set selection=exclusive
" Always show statusline
set laststatus=2
" Show line numbers
set number
" Show invisible char
set list
set listchars=tab:⇲\ ,trail:◦
" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" Line wrap
" To insert the elipsis, press ctrl-vu followed by the numeric code for elipsis: 2026
set wrap linebreak
set showbreak=↺
" Allows the left and right arrow keys to wrap around lines
set whichwrap+=<,>,h,l,[,]
" Backspace
set backspace=indent,eol,start
" Fix vim esc delay
set ttimeoutlen=100
" The default updatetime is too large for tagbar's response
set updatetime=500
" Prefer lightline status, don't need showmode
set noshowmode

" incsearch
set incsearch
if exists('##CmdlineEnter')
    augroup vimrc-incsearch-highlight
        autocmd!
        autocmd CmdlineEnter [/\?] :set hlsearch
        autocmd CmdlineEnter [/\?] cnoremap <Tab> <C-G>
        autocmd CmdlineEnter [/\?] cnoremap <S-Tab> <C-T>
        autocmd CmdlineLeave [/\?] :set nohlsearch
        autocmd CmdlineLeave [/\?] cunmap <Tab>
        autocmd CmdlineLeave [/\?] cunmap <S-Tab>
    augroup END
endif

" map the escape sequences to their Alt combinations
" ref: https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
let c='a'
while c <= 'z'
  exec "set <M-".c.">=\e".c
  exec "imap \e".c." <M-".c.">"
  let c = nr2char(1+char2nr(c))
endw

" tmux will send xterm-style keys when xterm-keys is on
" ref: http://unix.stackexchange.com/questions/29907/how-to-get-vim-to-work-with-tmux-properly/34723#34723
if &term =~ '^screen' || &term =~ '^tmux'
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
if &term =~ '^screen' || &term =~ '^tmux'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" YouCompleteMe
let g:ycm_extra_conf_globlist = ['~/work/*','/mnt/data[!/]*/*','!~/*']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1

" Slimux
let g:slimux_select_from_current_window = 1

" Colors
set cursorline
syntax on
colorscheme onedark
let g:load_doxygen_syntax = 1
if &term =~ '^xterm' || &term =~ '^tmux'
    highlight Comment cterm=italic
endif

" Key naming
execute "set <C-Home>=\e[1;5H"
execute "set <C-End>=\e[1;5F"

" Key mappings in normal mode
nnoremap <M-i> :YcmCompleter GoTo<CR>
" Naviaget Back
nnoremap <M-o> <C-O>
nnoremap <C-Home> gg
nnoremap <C-End> G
nnoremap <C-S> :w<CR>
nnoremap <expr><C-Left> "b"
nnoremap <expr><C-Right> "w"
nnoremap <expr><BS> "X"
" C-BS
nnoremap <expr><C-H> "\"_db"
" C-Del
nnoremap <expr><C-kDel> "\"_dw"
nnoremap <expr><C-X> "dd"

" Key mappings in insert mode
inoremap <C-kDel> <C-O>"_dw
inoremap <M-i> <C-C>:YcmCompleter GoTo<CR>
inoremap <M-o> <C-C><C-O>
inoremap <C-S> <C-O>:w<CR>
" Disable i_CTRL-V in favor for i_CTRL-Q
inoremap <C-v> <Nop>
cnoremap <C-v> <Nop>
" Github link
vnoremap <C-g> :Gbrowse!<Cr>

" grep
let &grepprg = $HOME . '/.cargo/bin/rg --vimgrep --no-heading'

" CtrlP
let g:ctrlp_map = '<M-p>'
let g:ctrlp_user_command = $HOME . '/.cargo/bin/rg --files --color=never --glob ""'
let g:ctrlp_use_caching = 0
let g:ctrlp_extensions = ['tag']
nnoremap <M-p><M-p> :CtrlPBuffer<CR>
nnoremap <M-p><M-t> :CtrlPTag<CR>
inoremap <M-p> <C-C>:CtrlP<CR>
inoremap <M-p><M-p> <C-C>:CtrlPBuffer<CR>

" Key mappings in command-line mode
" C-BS
noremap! <C-H> <C-W>

" Commentary
xmap <C-Q>  <Plug>Commentary
nmap <C-Q>  <Plug>Commentary
omap <C-Q>  <Plug>Commentary
nmap <C-Q><C-Q> <Plug>CommentaryLine

" Cutlass
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D

" Make a text object for previously changed text
" ref: http://vim.wikia.com/wiki/Selecting_your_pasted_text
xnoremap <silent> <expr> c ':<C-U>normal! ' . '`]' . strpart(getregtype(), 0, 1) . '`[<CR>'
onoremap <silent> <expr> c ':<C-U>normal! ' . '`]' . strpart(getregtype(), 0, 1) . '`[<CR>'

" signify
let g:signify_realtime = 1
" hunk text object
omap ic <plug>(signify-motion-inner-pending)
xmap ic <plug>(signify-motion-inner-visual)
omap ac <plug>(signify-motion-outer-pending)
xmap ac <plug>(signify-motion-outer-visual)
" Hunk jumping
nmap <M-Down> <plug>(signify-next-hunk)
nmap <M-Up> <plug>(signify-prev-hunk)

" Key mappings for slime
if !exists('g:slimux_map') | let g:slimux_map = "\<M-e>" | endif
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

" gutentags
"let g:gutentags_trace=1
let g:gutentags_ctags_extra_args = ['--languages=AnsiblePlaybook,Autoconf,Automake,Awk,Basic,C,C#,C++,Clojure,CPreProcessor,CUDA,DosBatch,Erlang,Fortran,Go,Iniconf,Java,JavaProperties,JavaScript,Lisp,Lua,M4,Make,MatLab,Maven2,ObjectiveC,OCaml,Pascal,Perl,Perl6,pod,Python,PythonLoggingConfig,R,RpmSpec,RSpec,Ruby,Rust,Scheme,Sh,SQL,SystemVerilog,Tcl,TclOO,Tex,Verilog,VHDL,Vim,XSLT,YACC,Yaml']
let g:gutentags_ctags_extra_args += ['--fields=+ailS', '--c-kinds=+p', '--c++-kinds=+p', '--extra=+q']
let g:gutentags_file_list_command = $HOME . '/.cargo/bin/rg --files'
augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

" vim-better-whitespace
let g:strip_whitelines_at_eof = 1
let g:show_spaces_that_precede_tabs = 1

" echofunc
let g:EchoFuncKeyNext = '<M-Down>'
let g:EchoFuncKeyPrev = '<M-Up>'

" ALE
let g:ale_lint_on_text_changed = 'never'

" fzf
nnoremap <C-F> :Rg<Space>

" vim-livedown
let g:livedown_autorun = 1
let g:livedown_open = 0

" Yank to tmux
if exists("##TextYankPost")
    function! s:onYanked() abort
        if $TMUX != ''
            call system("tmux load-buffer -", v:event.regcontents)
        endif
    endfunction

    augroup YankPost
        autocmd!
        autocmd TextYankPost * call s:onYanked()
    augroup END
endif
