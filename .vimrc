if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
" The following are examples of different formats supported.
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mhinz/vim-signify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'machakann/vim-highlightedyank'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'vim-python/python-syntax'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
Plug 'shime/vim-livedown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'   " Depends on lightline.vim and ale
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
Plug 'unblevable/quick-scope'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'pearofducks/ansible-vim'
Plug 'joshdick/onedark.vim'
Plug 'wsdjeg/vim-fetch'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Shougo/echodoc.vim'
" All of your Plugins must be added before the following line
" Initialize plugin system
call plug#end()

source ~/.vim/lightline.vim
source ~/.vim/searchable.vim

" Detect filetype
autocmd BufRead,BufNewFile */ansible/{**/,}*.yml set filetype=yaml.ansible
autocmd FileType gitcommit setlocal spell
autocmd FileType help noremap <buffer> q :q<cr>

" Add to .vimrc to enable project-specific vimrc
" exrc allows loading local executing local rc files.
" secure disallows the use of :autocmd, shell and write commands in local .vimrc files.
set exrc
set secure

set nocompatible
set hidden                    " required by vim-ctrlspace
set path+=**
set wildmenu
set wildmode=longest:full,full
set encoding=utf-8
set selection=exclusive
" Always show statusline
set laststatus=2
" To use echodoc/coc.nvim, you must increase 'cmdheight' value.
set cmdheight=2
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
" ins-completion
set completeopt-=preview
set completeopt+=popup
set completeopt+=longest
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

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
" map the escape sequences to their Alt combinations in terminal mode
" ref: https://github.com/macvim-dev/macvim/issues/868#issuecomment-466348034
function s:tmap_meta(key)
    call term_sendkeys(bufnr('%'), "\<Esc>" . a:key)
endfunction
let c='a'
while c <= 'z'
  exec "set <M-".c.">=\e".c
  exec "imap \e".c." <M-".c.">"
  exec "tnoremap <silent> <M-".c."> <C-W>:call <SID>tmap_meta('".c."')<CR>"
  let c = nr2char(1+char2nr(c))
endw

source ~/.vim/slimux.vim

" tmux will send xterm-style keys when xterm-keys is on
" ref: http://unix.stackexchange.com/questions/29907/how-to-get-vim-to-work-with-tmux-properly/34723#34723
if &term =~ '^screen' || &term =~ '^tmux'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <kDel>=\e[3;*~"
endif

" Change cursor styles (DECSCUSR) based on modes
" ref: https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html
let &t_SI = "\e[5 q"        " Blink Vertical line in insert mode
let &t_EI = "\e[2 q"        " Steady Block in normal mode
let &t_SR = "\e[3 q"        " Blink Underline in replace mode

" Prevent left moving one character when leaving insert mode
autocmd InsertLeave * :normal `^

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

" quick-scope
" Note: Customize colors before you set colorscheme
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary cterm=underline
augroup END

" Colors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

set cursorline
syntax on
" Disable italics because KiTTY + vim one dark will have very dark gray for
" Comment highlight
"let g:onedark_terminal_italics = 1
colorscheme onedark
let g:load_doxygen_syntax = 1
let g:python_highlight_all = 1

function! AtEndOfLine()
    return col(".") >= col("$") - 1
endfunction

" Key naming
execute "set <C-Home>=\e[1;5H"
execute "set <C-End>=\e[1;5F"

nnoremap <C-Home> gg
nnoremap <C-End> G
nnoremap <C-S> :w<CR>
nnoremap <expr><C-Left> "b"
nnoremap <expr><C-Right> "w"
nnoremap <expr><BS> "X"
" C-Del
nnoremap <expr><C-kDel> "\"_dw"
nnoremap <expr><C-X> "dd"

" Key mappings in insert mode
" Mimic Windows C-Del behavior
" Note: gJ - Join lines and don't insert or remove any spaces
inoremap <expr> <C-kDel> AtEndOfLine() ? '<C-O>gJ<C-O>"_dw' : '<C-O>"_dw'
inoremap <M-i> <C-C>:YcmCompleter GoTo<CR>
inoremap <M-o> <C-C><C-O>
inoremap <C-S> <C-O>:w<CR>
" Disable i_CTRL-V in favor for i_CTRL-Q
inoremap <C-V> <Nop>
cnoremap <C-V> <Nop>
" Github link
vnoremap <C-G> :Gbrowse!<CR>
" Use <CR> to confirm completion, `<C-G>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<C-G>u\<CR>"

" grep
let &grepprg = $HOME . '/.cargo/bin/rg --vimgrep --no-heading'

" Key mappings in insert or command-line mode
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
onoremap c :normal vc<CR>

" signify
" Note: g:signify_realtime will invalidate `previously changed or yanked text`
" so '[  `[  ']  `] will not work, even not realtime, file saving will
" invalidate them too.
let g:signify_realtime = 0
" hunk text object
omap ic <plug>(signify-motion-inner-pending)
xmap ic <plug>(signify-motion-inner-visual)
omap ac <plug>(signify-motion-outer-pending)
xmap ac <plug>(signify-motion-outer-visual)
" Hunk jumping
nmap <M-Down> <plug>(signify-next-hunk)
nmap <M-Up> <plug>(signify-prev-hunk)

" gutentags
"let g:gutentags_trace=1
let g:gutentags_ctags_extra_args = ['--languages=AnsiblePlaybook,Autoconf,Automake,Awk,Basic,C,C#,C++,Clojure,CPreProcessor,CUDA,DosBatch,Erlang,Fortran,Go,Iniconf,Java,JavaProperties,JavaScript,Lisp,Lua,M4,Make,MatLab,Maven2,ObjectiveC,OCaml,Pascal,Perl,Perl6,pod,Python,PythonLoggingConfig,R,RpmSpec,RSpec,Ruby,Rust,Scheme,Sh,SQL,SystemVerilog,Tcl,TclOO,Tex,Verilog,VHDL,Vim,XSLT,YACC,Yaml']
let g:gutentags_ctags_extra_args += ['--tag-relative=yes', '--fields=+ailmnS', '--c-kinds=+p', '--c++-kinds=+p', '--extras=+q']
let g:gutentags_file_list_command = expand('~/.cargo/bin/rg --files')
let g:gutentags_ctags_exclude = ['*.ini', '*.min.js', '*.css']
augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

" Prepare system wide ctags
let g:gutentags_ctags_executable = 'ctags'
let s:systags = expand('~/.vim/systags')
let s:sysincludes = ['/usr/include', '/usr/local/include']
if !filereadable(s:systags) && executable(g:gutentags_ctags_executable)
    let cmd = join([g:gutentags_ctags_executable, '-R', '-f', s:systags] + g:gutentags_ctags_extra_args + s:sysincludes)
    call system(cmd)
endif
let &tags .= ',' . s:systags

" vim-better-whitespace
let g:strip_whitelines_at_eof = 1
let g:show_spaces_that_precede_tabs = 1

" ALE
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_balloons=1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_enabled=1
augroup disable_ale
    autocmd InsertEnter * let g:ale_enabled=0
    autocmd InsertEnter * silent! :call ale#highlight#UpdateHighlights()
    autocmd InsertLeave * let g:ale_enabled=1
    autocmd InsertLeave * silent! :call ale#highlight#UpdateHighlights()
augroup END

" fzf
nnoremap <silent> <C-P> :FZF -m<CR>
nnoremap <silent> <M-p> :Buffers<CR>
" Find in current buffer
nnoremap <C-F> :BLines<Space>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <C-X><C-K> <plug>(fzf-complete-word)
imap <C-X><C-F> <plug>(fzf-complete-path)
imap <C-X><C-J> <plug>(fzf-complete-file-ag)
imap <C-X><C-L> <plug>(fzf-complete-line)
" Allow passing optional flags into the Rg command.
" Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)
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
let $FZF_DEFAULT_COMMAND = '{ rg --files --hidden & git ls-files; } | sort -u'

" vim-livedown
let g:livedown_autorun = 1
let g:livedown_open = 0

" coc.nvim
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Snippet expand and jump
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" highlightedyank
let g:highlightedyank_highlight_duration = 200

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
