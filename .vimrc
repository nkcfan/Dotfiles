if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
" The following are examples of different formats supported.
if has('nvim-0.5.0')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    Plug 'nvim-treesitter/nvim-treesitter-refactor'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
else
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'vim-python/python-syntax'
    Plug 'wellle/targets.vim'
    Plug 'tommcdo/vim-exchange'
endif
Plug 'mhinz/vim-signify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sbdchd/neoformat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar', { 'on': ['Tagbar', 'TagbarToggle'] }
Plug 'shime/vim-livedown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'   " Depends on lightline.vim and ale
Plug 'drzel/vim-line-no-indicator'
Plug 'svermeulen/vim-cutlass'
Plug 'jpalardy/vim-slime'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tommcdo/vim-ninja-feet'
Plug 'unblevable/quick-scope'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'pearofducks/ansible-vim'
Plug 'stephpy/vim-yaml'
Plug 'joshdick/onedark.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/sonokai'
Plug 'wsdjeg/vim-fetch'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Shougo/echodoc.vim', { 'on': ['EchoDocEnable'] }
Plug 'liuchengxu/vim-which-key'
" All of your Plugins must be added before the following line
" Initialize plugin system
call plug#end()

source ~/.vim/lightline.vim
source ~/.vim/searchable.vim

syntax on
let g:xml_syntax_folding = 1

" Detect filetype
autocmd BufRead,BufNewFile */ansible/{**/,}*.yml set filetype=yaml.ansible
autocmd FileType gitcommit setlocal spell
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
autocmd FileType xml setlocal foldmethod=syntax | :%foldopen!

" Add to .vimrc to enable project-specific vimrc
" exrc allows loading local executing local rc files.
" secure disallows the use of :autocmd, shell and write commands in local .vimrc files.
set exrc
set secure

set nocompatible
set hidden
set path+=**
set wildmenu
set wildmode=longest:full,full
set encoding=utf-8
"set selection=exclusive        " conflict with nvim-treesitter
set foldlevelstart=20
" Always show statusline
set laststatus=2
" To use echodoc/coc.nvim, you must increase 'cmdheight' value.
set cmdheight=2
" Show line numbers
set number
set relativenumber
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
" The default updatetime is too large for tagbar/coc.nvim's response
set updatetime=500
" Prefer lightline status, don't need showmode
set noshowmode
" ins-completion
if has("patch-8.1.1880")
    set completeopt+=popup
endif
set completeopt-=preview
set completeopt+=longest
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Show substitution effect incrementally
if exists('&inccommand')
    set inccommand=split
endif

" Dictionary
if has('win32')
    set dictionary+=~/.vim/dict/words
else
    " Please install the package wamerican
endif

" Scroll hit to middle if not on same page
" If cursor is in first or last line of window, scroll to middle line.
" ref: https://vim.fandom.com/wiki/Make_search_results_appear_in_the_middle_of_the_screen
function s:MaybeMiddle()
  if winline() == 1 || winline() == winheight(0)
    normal! zz
  endif
endfunction

" incsearch
set incsearch
if exists('##CmdlineEnter')
    augroup vimrc-incsearch-highlight
        autocmd!
        if (has("nvim"))
            " nvim does not support `[ch]` pattern
            autocmd CmdlineEnter / :set hlsearch
            autocmd CmdlineEnter / cnoremap <Tab> <C-G>
            autocmd CmdlineEnter / cnoremap <S-Tab> <C-T>
            autocmd CmdlineLeave / :set nohlsearch
            autocmd CmdlineLeave / cunmap <Tab>
            autocmd CmdlineLeave / cunmap <S-Tab>
            autocmd CmdlineEnter \? :set hlsearch
            autocmd CmdlineEnter \? cnoremap <Tab> <C-G>
            autocmd CmdlineEnter \? cnoremap <S-Tab> <C-T>
            autocmd CmdlineLeave \? :set nohlsearch
            autocmd CmdlineLeave \? cunmap <Tab>
            autocmd CmdlineLeave \? cunmap <S-Tab>
        else
            autocmd CmdlineEnter [/\?] :set hlsearch
            autocmd CmdlineEnter [/\?] cnoremap <Tab> <C-G>
            autocmd CmdlineEnter [/\?] cnoremap <S-Tab> <C-T>
            autocmd CmdlineLeave [/\?] :set nohlsearch
            autocmd CmdlineLeave [/\?] cunmap <Tab>
            autocmd CmdlineLeave [/\?] cunmap <S-Tab>
        endif
    augroup END
endif

" map the escape sequences to their Alt combinations
" ref: https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
" map the escape sequences to their Alt combinations in terminal mode
" ref: https://github.com/macvim-dev/macvim/issues/868#issuecomment-466348034
" Note: tnoremap was introduced since vim 8.0.1108
" ref: https://github.com/vim/vim/commit/69fbc9e1dab176f345719436cd89d854df0a2abd
if !has("nvim") && has("patch-8.0.1108")
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
endif

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

" Enable undercurl
let &t_Cs = "\e[6m"
let &t_Ce = "\e[24m"

" Prevent left moving one character when leaving insert mode
autocmd InsertLeave * :normal! `^

" Default normal yanks to use the system clipboard
" Note: only in GUI nvim
if has('nvim') && exists('g:GuiLoaded')
    set clipboard=unnamedplus
endif

" Set mouse in all mode
set mouse+=a
" Fix mouse dragging splitters inside tmux
" Note: ttymouse is not supported in nvim
if !has('nvim') && (&term =~ '^screen' || &term =~ '^tmux')
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

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
let g:load_doxygen_syntax = 1
let g:python_highlight_all = 1

" onedark colorscheme
source ~/.vim/onedark.vim
colorscheme onedark
" gruvbox
let g:gruvbox_contrast_dark = "hard"
let g:gitgutter_override_sign_column_highlight = 1
let g:gruvbox_invert_selection = 0
if !exists('g:GuiLoaded')
    let g:gruvbox_guisp_fallback = "bg"
endif
colorscheme gruvbox
" sonokai
let g:sonokai_style = "shusia"
let g:sonokai_disable_italic_comment = 1
" let g:sonokai_transparent_background = 1
colorscheme sonokai

function! AtEndOfLine()
    return col(".") >= col("$") - 1
endfunction

" Leader key mappings
" Note: do not use format like <KeyName>, which is not compatible with
" vim-which-key
let maplocalleader = " "
let mapleader = "\\"
nnoremap <LocalLeader>b                     :TagbarToggle<CR>
nnoremap <LocalLeader>e                     :EchoDocEnable<CR>
nnoremap <LocalLeader>U                     :CocUpdateSync<CR>:PlugUpgrade<CR>:PlugClean!<CR>:PlugUpdate --sync<CR>
nnoremap <LocalLeader>gb                    :Gblame<CR>
noremap  <LocalLeader>gk                    :Gbrowse!<CR>
nnoremap <LocalLeader>gd                    :SignifyHunkDiff<CR>
" Open fugitive Gstatus and jump to the first unstaged file
nmap     <LocalLeader>gs                    :vertical G<CR>gU
" Symbol renaming.
nnoremap <Leader>rn                         :ALERename<CR>
vnoremap <Leader>fm                         :Neoformat<CR>
nnoremap <Leader>fm                         :ALEFix<CR>
vnoremap <Leader>fi                         :Neoformat! 

" Key naming
execute "set <C-Home>=\e[1;5H"
execute "set <C-End>=\e[1;5F"

nnoremap <C-Home> gg0
nnoremap <C-End> G$
nnoremap <C-S> :w<CR>
nnoremap <M-w> :confirm bdelete<CR>
nnoremap <expr><C-Left> "b"
nnoremap <expr><C-Right> "w"
nnoremap <expr><BS> "X"
" Move by virtual lines when used without a count, and by physical lines when used with a count
" ref: https://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier/
" And push long jump into jumplist
" ref: https://medium.com/breathe-publication/understanding-vims-jump-list-7e1bfc72cdf0
noremap <silent> <expr> j (v:count == 0 ? 'gj' : (v:count == 1 ? '' : "m'" . v:count ) . 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : (v:count == 1 ? '' : "m'" . v:count ) . 'k')
noremap <silent> <expr> <Up> (v:count == 0 ? 'g<Up>' : '<Up>')
noremap <silent> <expr> <Down> (v:count == 0 ? 'g<Down>' : '<Down>')
" C-Del
nmap <C-Del> <C-kDel>
nnoremap <expr><C-kDel> '"_dw'
nnoremap <Del> "_x

" Key mappings in insert mode
" Mimic Windows C-Del behavior
" Note: gJ - Join lines and don't insert or remove any spaces
" Note: ◦<C-O>x - To erase a visible char in order to keep indentation
imap <C-Del> <C-kDel>
inoremap <expr> <C-kDel> AtEndOfLine() ? '◦<C-O>x<C-O>gJ' : '<C-O>"_dw'
inoremap <M-o> <C-C><C-O>
inoremap <C-S> <C-O>:w<CR>
" Disable i_CTRL-V in favor for i_CTRL-Q
inoremap <C-V> <Nop>
cnoremap <C-V> <Nop>
" Note: tnoremap was introduced since vim 8.0.1108
" ref: https://github.com/vim/vim/commit/69fbc9e1dab176f345719436cd89d854df0a2abd
if !has("nvim") && has("patch-8.0.1108")
    tnoremap <C-V> <Nop>
endif
" Github link
vnoremap <C-G> :Gbrowse!<CR>
" Use <CR> to confirm completion, `<C-G>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR>    pumvisible() ? "<C-Y>" : "<C-G>u<CR>"
inoremap <expr> <Tab>   pumvisible() ? "<C-Y>" : "<Tab>"
inoremap <expr> <Left>  pumvisible() ? "<C-E>" : "<Left>"
inoremap <expr> <Right> pumvisible() ? "<C-Y>" : "<Right>"
" Command mode wildmenu key mappings
cnoremap <expr> <Up>    pumvisible() ? "<C-P>" : "<Up>"
cnoremap <expr> <Down>  pumvisible() ? "<C-N>" : "<Down>"

" Key mappings in insert or command-line mode
" C-BS
noremap! <C-H> <C-W>
noremap! <C-BS> <C-W>
vnoremap <BS> "_d
inoremap <M-BS> <C-W>

" Natural Home key
" ref: https://stackoverflow.com/a/15459337/2514803
function ExtendedHome()
    let column = col('.')
    normal! ^
    if column == col('.')
        normal! 0
    endif
endfunction
noremap <silent> <Home> :call ExtendedHome()<CR>
inoremap <silent> <Home> <C-O>:call ExtendedHome()<CR>

" Natural PageUp and PageDown
" ref: http://vimrc-dissection.blogspot.com/2009/02/fixing-pageup-and-pagedown.html
map <silent> <PageUp> 1000<C-U>
map <silent> <PageDown> 1000<C-D>
imap <silent> <PageUp> <C-O>1000<C-U>
imap <silent> <PageDown> <C-O>1000<C-D>
set nostartofline

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
xnoremap <silent> <expr> gp ':<C-U>normal! ' . '`]' . strpart(getregtype(), 0, 1) . '`[<CR>'
onoremap gp :normal! vgp<CR>

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
nmap <M-Down> <plug>(signify-next-hunk):call <SID>MaybeMiddle()<CR>
nmap <M-Up> <plug>(signify-prev-hunk):call <SID>MaybeMiddle()<CR>

" grep
let &grepprg = expand('~/.cargo/bin/rg --vimgrep --no-heading')

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
" Moving between ALE warnings and errors quickly
nmap <silent> <C-S-Up> <Plug>(ale_previous):call <SID>MaybeMiddle()<CR>
nmap <silent> <C-S-Down> <Plug>(ale_next):call <SID>MaybeMiddle()<CR>
" ALE config
let g:ale_lint_on_text_changed = 'never'
" Note: Mouse move triggers mess characters when enabling balloons together with coc.nvim coc-references window open
" Note: seems working well with coc-fzf, only in vim
let g:ale_set_balloons=1
let g:ale_floating_preview=1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_enabled=1
let g:ale_sh_bashate_options = '-i E006'
" Disable ALE text highlight in insert mode to help readability
" Note: Leave insert mode by <Esc>, if <C-C> then ALE text highlight will not
" come back
augroup disable_ale_insert
    autocmd!
    autocmd InsertEnter * silent! let g:ale_enabled=0 | call ale#highlight#UpdateHighlights()
    autocmd InsertLeave * silent! let g:ale_enabled=1 | call ale#highlight#UpdateHighlights()
augroup END

" fzf
nnoremap <LocalLeader>p :FZF -m<CR>
nnoremap <silent> <M-p> :Buffers<CR>
" Find in current buffer
nnoremap <C-F> :BLines<Space><C-R>=expand('<cword>')<CR>
" Mapping selecting mappings
nmap <Leader><tab> <plug>(fzf-maps-n)
xmap <Leader><tab> <plug>(fzf-maps-x)
omap <Leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <C-X><C-F> <plug>(fzf-complete-path)
imap <C-X><C-J> <plug>(fzf-complete-file-ag)
imap <C-X><C-L> <plug>(fzf-complete-line)
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

" vim-livedown
let g:livedown_autorun = 1
let g:livedown_open = 0

" coc.nvim
" GoTo code navigation.
nmap <silent> vv :<C-u>call CocAction('jumpDefinition')<CR>:call <SID>MaybeMiddle()<CR>
nmap <silent> gD :<C-u>call CocAction('jumpDeclaration')<CR>:call <SID>MaybeMiddle()<CR>
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> rr <Plug>(coc-references)
" CoC Settings
let g:coc_global_extensions = [
            \ 'coc-git',
            \ 'coc-pyright',
            \ ]
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

" diff mode
" Note: disable internal diff option in order to enable FilterWritePost
set diffopt-=internal
" Note: set shelltemp option in order to enable FilterWritePost
set shelltemp
" Note: reload colorscheme is not needed for Neovim
augroup diff_mode
    autocmd!
    autocmd FilterWritePost *
        \ if &diff |
            \ exec "colorscheme " . g:colors_name |
            \ exec "nnoremap <buffer><S-Left>    :diffget //2<CR>" |
            \ exec "nnoremap <buffer><S-Right>   :diffget //3<CR>" |
        \ endif
    autocmd BufWinLeave fugitive://*
        \ exec "colorscheme " . g:colors_name |
augroup END

" vim-which-key
nnoremap <silent><expr> <Leader>            ":<C-U>WhichKey '" . get(g:,"mapleader","\\") . "'<CR>"
nnoremap <silent><expr> <LocalLeader>       ":<C-U>WhichKey '" . get(g:,"maplocalleader","\\") . "'<CR>"
nnoremap <silent> g                         :<C-U>WhichKey 'g'<CR>
" Show vim-which-key in fugitive filetype
augroup fugitive_which_key
    autocmd!
    " Note: it does not support vim default mappings because they are not in nmap
    autocmd FileType fugitive
        \ nnoremap <buffer><silent><expr> c     ":<C-U>WhichKey 'c'<CR>" |
        \ nnoremap <buffer><silent><expr> d     ":<C-U>WhichKey 'd'<CR>" |
        \ nnoremap <buffer><silent><expr> r     ":<C-U>WhichKey 'r'<CR>" |
        \ nnoremap <buffer><silent><expr> [     ":<C-U>WhichKey '['<CR>" |
        \ nnoremap <buffer><silent><expr> ]     ":<C-U>WhichKey 'd'<CR>" |
        \ nnoremap <buffer><silent><expr> g     ":<C-U>WhichKey 'g'<CR>" |
        " EOL
augroup END
let g:which_key_use_floating_win = 0
let g:which_key_fallback_to_native_key = 1

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
