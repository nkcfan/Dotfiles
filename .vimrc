if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
" The following are examples of different formats supported.
if has('nvim-0.5.0')
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    Plug 'nvim-treesitter/nvim-treesitter-refactor'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'neovim/nvim-lspconfig'
    Plug 'Shougo/deoplete.nvim'
    Plug 'deoplete-plugins/deoplete-lsp'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'nathunsmitty/nvim-ale-diagnostic'
    Plug 'ojroques/nvim-lspfuzzy'
else
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'vim-python/python-syntax'
    Plug 'wellle/targets.vim'
    Plug 'tommcdo/vim-exchange'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'antoinemadec/coc-fzf'
endif
Plug 'mhinz/vim-signify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Chiel92/vim-autoformat'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar', { 'on': ['Tagbar', 'TagbarToggle'] }
Plug 'plasticboy/vim-markdown'
Plug 'shime/vim-livedown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'zackhsi/fzf-tags'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'   " Depends on lightline.vim and ale
Plug 'drzel/vim-line-no-indicator'
Plug 'svermeulen/vim-cutlass'
Plug 'jpalardy/vim-slime'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'cedarbaum/fugitive-azure-devops.vim'
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
Plug 'bluz71/vim-moonfly-colors'
Plug 'wsdjeg/vim-fetch'
Plug 'ludovicchabant/vim-gutentags'
Plug 'liuchengxu/vim-which-key'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" All of your Plugins must be added before the following line
" Initialize plugin system
call plug#end()

syntax on
let g:xml_syntax_folding = 1

" Detect filetype
augroup detect_filetype
    autocmd!
    autocmd BufRead,BufNewFile */ansible/{**/,}*.yml set filetype=yaml.ansible
    autocmd FileType gitcommit,c,cpp,python,markdown,vim,yaml setlocal spell
    autocmd BufWinEnter * ++nested if &spell | syntax enable | endif
    autocmd User Fugitive if &buftype == '' | call feedkeys(":Git! difftool | cclose | echon '' \<CR>") | endif
    autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
    autocmd FileType xml setlocal foldmethod=syntax | call feedkeys(":%foldopen!\<CR>")
augroup END

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
" Recommended completeopt for coc.nvim or completion-nvim
set completeopt+=menuone,noinsert
let &spellfile = expand('~/.vim/spell/' . &spelllang . '.' . &encoding . '.add')
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Show substitution effect incrementally
if exists('&inccommand')
    set inccommand=split
endif

" vim-yaml
let g:yaml_limit_spell = 1

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 20

" Dictionary
if has('win32')
    set dictionary+=~/.vim/dict/words
else
    " Please install the package wamerican
endif

" Scroll hit to middle if not on same page
" If cursor is in first or last line of window, scroll to middle line.
" ref: https://vim.fandom.com/wiki/Make_search_results_appear_in_the_middle_of_the_screen
function MaybeMiddle()
  if winline() == 1 || winline() == winheight(0)
    normal! zz
  endif
endfunction

" incsearch
" Disable incsearch/hlsearch because default on in Neovim
set noincsearch
set nohlsearch
if exists('##CmdlineEnter')
    augroup vimrc-incsearch-highlight
        autocmd!
        if (has("nvim"))
            " nvim does not support `[ch]` pattern
            autocmd CmdlineEnter / set incsearch | set hlsearch
            autocmd CmdlineEnter / cnoremap <Tab> <C-G>
            autocmd CmdlineEnter / cnoremap <S-Tab> <C-T>
            autocmd CmdlineLeave / set noincsearch | set nohlsearch
            autocmd CmdlineLeave / cunmap <Tab>
            autocmd CmdlineLeave / cunmap <S-Tab>
            autocmd CmdlineEnter \? set incsearch | set hlsearch
            autocmd CmdlineEnter \? cnoremap <Tab> <C-G>
            autocmd CmdlineEnter \? cnoremap <S-Tab> <C-T>
            autocmd CmdlineLeave \? set noincsearch | set nohlsearch
            autocmd CmdlineLeave \? cunmap <Tab>
            autocmd CmdlineLeave \? cunmap <S-Tab>
        else
            autocmd CmdlineEnter [/\?] set incsearch | set hlsearch
            autocmd CmdlineEnter [/\?] cnoremap <Tab> <C-G>
            autocmd CmdlineEnter [/\?] cnoremap <S-Tab> <C-T>
            autocmd CmdlineLeave [/\?] set noincsearch | set nohlsearch
            autocmd CmdlineLeave [/\?] cunmap <Tab>
            autocmd CmdlineLeave [/\?] cunmap <S-Tab>
        endif
    augroup END
endif

" Key naming
execute "set <C-Home>=\e[1;5H"
execute "set <C-End>=\e[1;5F"

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

" Set mouse in all mode
set mouse+=a
" Fix mouse dragging splitters inside tmux
" Note: ttymouse is not supported in nvim
if !has('nvim') && (&term =~ '^screen' || &term =~ '^tmux')
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" Colors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $COLORTERM="truecolor"
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

" Choose a colorscheme
colorscheme gruvbox
colorscheme onedark
colorscheme moonfly

function! AtEndOfLine()
    return col(".") >= col("$") - 1
endfunction

function UpgradeAll()
    if exists('*coc#util#update_extensions')
        call coc#util#update_extensions()
    endif
    execute 'PlugUpgrade'
    execute 'PlugClean!'
    execute 'PlugUpdate --sync'
endfunction

" Toggle spell checking
" ref: https://gist.github.com/brandonpittman/9d15134057c7267a88a8
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

" Toggle signcolumn
function! ToggleSignColumn()
    if &number == 1
        set signcolumn=no
        set nonumber
        set norelativenumber
    else
        set signcolumn=auto
        set number
        set relativenumber
    endif
endfunction

" Show line numbers
call ToggleSignColumn()
" Leader key mappings
" Note: do not use format like <KeyName>, which is not compatible with
" vim-which-key
let maplocalleader = " "
let mapleader = "\\"
nnoremap <LocalLeader>b                     :TagbarToggle<CR>
nnoremap <LocalLeader>U                     :call UpgradeAll()<CR>
nnoremap <LocalLeader>gb                    :Gblame<CR>
noremap  <LocalLeader>gk                    :Gbrowse!<CR>
nnoremap <LocalLeader>gd                    :SignifyHunkDiff<CR>
noremap  <LocalLeader>gu                    :SignifyHunkUndo<CR>
" Open fugitive Gstatus and jump to the first unstaged file
nmap     <LocalLeader>gs                    :vertical G<CR>gU
nnoremap <LocalLeader>gq                    :Git! difftool<CR>:cclose<CR>
nnoremap <LocalLeader>ts                    :call ToggleSpellCheck()<CR>
nnoremap <LocalLeader>tn                    :call ToggleSignColumn()<CR>
" Symbol renaming.
nnoremap <Leader>rn                         :ALERename<CR>

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
" Note: <Nop> does work well in Neovim
inoremap <silent> <C-V>                     <C-O>:<CR>
cnoremap <silent> <C-V>                     a<BS>
" Note: tnoremap was introduced since vim 8.0.1108
" ref: https://github.com/vim/vim/commit/69fbc9e1dab176f345719436cd89d854df0a2abd
if !has("nvim") && has("patch-8.0.1108")
    tnoremap <C-V> <Nop>
endif
" Use <CR> to confirm completion, `<C-G>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR>    pumvisible() ? "<C-Y>" : "<C-G>u<CR>"
inoremap <expr> <Tab>   pumvisible() ? "<C-Y>" : "<Tab>"
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
omap ih <plug>(signify-motion-inner-pending)
xmap ih <plug>(signify-motion-inner-visual)
omap ah <plug>(signify-motion-outer-pending)
xmap ah <plug>(signify-motion-outer-visual)

" grep
let &grepprg = expand('~/.cargo/bin/rg --vimgrep --no-heading')
set grepformat^=%f:%l:%c:%m

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
