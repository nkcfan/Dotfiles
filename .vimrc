let g:PluginSpec_Common = {
            \ 'ojroques/vim-oscyank': { },
            \ 'ntpeters/vim-better-whitespace': { },
            \ 'majutsushi/tagbar': { 'on': ['Tagbar', 'TagbarToggle'] },
            \ 'plasticboy/vim-markdown': { 'ft': ['markdown' ] },
            \ 'vim-pandoc/vim-pandoc-syntax': { 'ft': ['markdown', 'pandoc'] },
            \ 'junegunn/fzf': { 'dir': '~/.fzf', 'do': './install --all' },
            \ 'junegunn/fzf.vim': { },
            \ 'zackhsi/fzf-tags': { },
            \ 'drzel/vim-line-no-indicator': { },
            \ 'jpalardy/vim-slime': { },
            \ 'tpope/vim-repeat': { },
            \ 'tpope/vim-surround': { },
            \ 'tpope/vim-eunuch': { },
            \ 'tpope/vim-fugitive': { },
            \ 'tpope/vim-rhubarb': { },
            \ 'cedarbaum/fugitive-azure-devops.vim': { },
            \ 'tommcdo/vim-ninja-feet': { },
            \ 'unblevable/quick-scope': { },
            \ 'xolox/vim-misc': { },
            \ 'xolox/vim-colorscheme-switcher': { 'dependencies': ['xolox/vim-misc'] },
            \ 'pearofducks/ansible-vim': { 'ft': ['yaml.ansible'] },
            \ 'stephpy/vim-yaml': { 'ft': ['yaml'] },
            \ 'wsdjeg/vim-fetch': { },
            \ 'ludovicchabant/vim-gutentags': { },
            \ 'alok/notational-fzf-vim': { },
            \ }

" Disable plugins in vscode-neovim
if !exists('g:vscode')
    let g:PluginSpec_Common['itchyny/lightline.vim'] = { }
endif

if !has('nvim')
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    call plug#begin('~/.vim/bundle')
    Plug 'svermeulen/vim-cutlass'
    Plug 'sainnhe/sonokai'
    " Plug 'joshdick/onedark.vim'
    " Plug 'gruvbox-community/gruvbox'
    " Plug 'bluz71/vim-moonfly-colors'
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'vim-python/python-syntax'
    Plug 'wellle/targets.vim'
    Plug 'tommcdo/vim-exchange'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'antoinemadec/coc-fzf'
    Plug 'tpope/vim-commentary'
    Plug 'w0rp/ale'
    Plug 'maximbaz/lightline-ale'   " Depends on lightline.vim and ale
    Plug 'ConradIrwin/vim-bracketed-paste'
    Plug 'Chiel92/vim-autoformat'

    for [plugin, args] in items(g:PluginSpec_Common)
        call plug#(plugin, args)
    endfor

    " All of your Plugins must be added before the following line
    " Initialize plugin system
    call plug#end()
endif

syntax on
let g:xml_syntax_folding = 1

" Detect filetype
augroup detect_filetype
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead */ansible/{**/,}*.yml set filetype=yaml.ansible
    autocmd BufNewFile,BufFilePre,BufRead {docker-,}compose.y{a,}ml set filetype=yaml.docker-compose
    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    autocmd FileType gitcommit,c,cpp,go,python,markdown,vim,yaml call DefaultSpellCheck()
    autocmd BufWinEnter * ++nested if &spell | syntax enable | endif
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
" Always use the system clipboard for all operations, instead of interacting with the '+' and/or '*' registers explicitly
set clipboard+=unnamedplus
"set selection=exclusive        " conflict with nvim-treesitter
set foldlevel=20
set foldlevelstart=20
" Always show statusline
if has('nvim')
    set laststatus=3
else
    set laststatus=2
endif
" Show invisible char
set list
set listchars=tab:⇲\ ,trail:◦
set fillchars=eob:\ ,fold:\ ,foldopen:,foldsep:\ ,foldclose:
" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" Line wrap
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
if !exists('g:vscode')
    set noshowmode
endif
" ins-completion
if has("patch-8.1.1880")
    set completeopt+=popup
endif
set completeopt-=preview
set completeopt+=longest
" Recommended completeopt for coc.nvim or completion-nvim
set completeopt+=menuone,noinsert
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Running the native Windows vim in msys or cygwin, do no use bash
if has('win32')
    let &shell='cmd.exe'
else
    let &shell='bash -l'
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

" Executable path
if exists('g:vscode')
    " For ripgrep(rg)
    let $PATH .= ':' . $HOME . '/.cargo/bin'
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

" Paste in GUI mode
inoremap <S-Insert> <C-R><C-O>*
cnoremap <S-Insert> <C-R>*
tnoremap <S-Insert> <C-\><C-N>"*pi

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
  let $COLORTERM="truecolor"
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" " Customize highlight after ColorScheme changed
" augroup my_colors
"     autocmd!
"     autocmd ColorScheme * highlight SpellBad cterm=undercurl gui=undercurl
" augroup END
"
set cursorline
let g:load_doxygen_syntax = 1
let g:python_highlight_all = 1

if !has('nvim-0.5.0')
    " Choose a colorscheme
    " colorscheme gruvbox
    " colorscheme onedark
    " colorscheme moonfly
    " sonokai
    let g:sonokai_style = 'shusia'
    let g:sonokai_enable_italic = 1
    let g:sonokai_disable_italic_comment = 1
    let g:sonokai_diagnostic_virtual_text = 'colored'
    " let g:sonokai_transparent_background = 1
    colorscheme sonokai
endif

function! AtEndOfLine()
    return col(".") >= col("$") - 1
endfunction

function UpgradeAll()
    if exists('*coc#util#update_extensions')
        call coc#util#update_extensions()
    endif
    if exists(':PlugUpgrade')
        execute 'PlugUpgrade'
        execute 'PlugClean!'
        execute 'PlugUpdate --sync'
    endif
    if exists(':Lazy')
        execute 'Lazy sync'
    endif
endfunction

function! DefaultSpellCheck()
    let fname = fnamemodify(expand("%"), ":~:.")
    if fname != ''
        setlocal spell
        setlocal spelloptions=camel
        let &l:spellfile=expand('~/.vim/spell/' . &spelllang . '.' . &encoding . '.add')
    endif
endfunction

" Toggle spell checking
" ref: https://gist.github.com/brandonpittman/9d15134057c7267a88a8
function! ToggleSpellCheck()
    setlocal spell!
    setlocal spell?
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
set nonumber
call ToggleSignColumn()
" Leader key mappings
" Note: do not use format like <KeyName>, which is not compatible with
let maplocalleader = " "
let mapleader = "\\"
nnoremap <LocalLeader>b                     :TagbarToggle<CR>
nnoremap <LocalLeader>U                     :call UpgradeAll()<CR>
nnoremap <LocalLeader>gb                    :Git blame<CR>
noremap  <LocalLeader>gk                    :GBrowse!<CR>
" Open fugitive Gstatus and jump to the first unstaged file
nmap     <LocalLeader>gs                    :vertical G<CR>gU
nnoremap <LocalLeader>gq                    :Git! difftool<CR>:cclose<CR>
nnoremap <LocalLeader>tn                    :call ToggleSignColumn()<CR>
nnoremap <LocalLeader>ts                    :call ToggleSpellCheck()<CR>
nnoremap <LocalLeader>tw                    <cmd>ToggleWhitespace<CR>
nnoremap <LocalLeader>ym                    :let @*=trim(execute('1messages')) \| echo 'Last message yanked'<CR>
nnoremap <LocalLeader>md                    :let @*=system('powershell.exe ~/bin/clip2markdown.ps1') \| echo 'Clipboard as markdown yanked'<CR>

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
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : (v:count == 1 ? '' : "m'" . v:count ) . 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : (v:count == 1 ? '' : "m'" . v:count ) . 'k')
noremap <silent> <expr> <Up> (v:count == 0 ? 'g<Up>' : '<Up>')
noremap <silent> <expr> <Down> (v:count == 0 ? 'g<Down>' : '<Down>')

" Del will follow the register of `d`
nmap <Del> dl
smap <Del> d
xmap <Del> d

" Mimic Windows C-Del behavior
nmap <C-Del> <C-kDel>
imap <C-Del> <C-kDel>
nmap <C-kDel> dw
" Note: gJ - Join lines and don't insert or remove any spaces
" Note: ◦<C-O>x - To erase a visible char in order to keep indentation
inoremap <expr> <C-kDel> AtEndOfLine() ? '◦<C-O>x<C-O>gJ' : '<C-O>"_dw'

" Save to file
inoremap <C-S> <C-O>:w<CR>

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
" Note: scroll window instead of moving cursor near the tail of file
function ExtendedPageDown(prefix)
    let a = line('.') - line('w0')
    let b = line('$') - line('w$')

    if a < b - 1 || b >= winheight(0)
        return a:prefix.."1000\<C-D>"
    elseif b > 1
        return a:prefix..string(b).."\<C-E>"
    else
        return ""
    endif
endfunction
" Note: scroll window instead of moving cursor near the head of file
function ExtendedPageUp(prefix)
    let a = line('w$') - line('.')
    let b = line('w0')

    if a < b - 1 || b >= winheight(0)
        return a:prefix.."1000\<C-U>"
    elseif b > 1
        return a:prefix..string(b - 1).."\<C-Y>"
    else
        return ""
    endif
endfunction
noremap     <expr> <PageUp>     ExtendedPageUp("")
noremap     <expr> <PageDown>   ExtendedPageDown("")
inoremap    <expr> <PageUp>     ExtendedPageUp("\<C-O>")
inoremap    <expr> <PageDown>   ExtendedPageDown("\<C-O>")
set nostartofline

" Cutlass
if !has('nvim')
    nnoremap m d
    xnoremap m d
    nnoremap mm dd
    nnoremap M D
endif

" Make a text object for previously changed text
" ref: http://vim.wikia.com/wiki/Selecting_your_pasted_text
xnoremap <silent> <expr> gp ':<C-U>normal! ' . '`]' . strpart(getregtype(), 0, 1) . '`[<CR>'
onoremap gp :normal! vgp<CR>

" grep
let &grepprg = expand('~/.cargo/bin/rg --vimgrep --no-heading')
set grepformat^=%f:%l:%c:%m

" Yank to tmux or osc52
if has('nvim')
    if has('wsl')
        let g:clipboard = {
                \   'name': 'WslClipboard',
                \   'copy': {
                \      '+': 'clip.exe',
                \      '*': 'clip.exe',
                \    },
                \   'paste': {
                \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \   },
                \   'cache_enabled': 0,
                \ }
    elseif empty($TMUX) && !empty($TERM) && $TERM != 'vtpcon'
        let g:clipboard = {
                \   'name': 'osc52',
                \   'copy': {'+': {lines, regtype -> OSCYank(join(lines, "\n"))}},
                \   'paste': {'+': {-> [split(getreg(''), '\n'), getregtype('')]}},
                \ }
    endif
elseif exists("##TextYankPost")
    function! s:onYanked() abort
        call system("tmux load-buffer -", v:event.regcontents)
    endfunction

    augroup YankPost
        autocmd!
        if !empty($TERM) && $TERM != 'vtpcon'
            autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankReg +' | endif
        elseif !empty($TMUX)
            autocmd TextYankPost * call s:onYanked()
        endif
    augroup END
endif

" notational-fzf-vim
let g:nv_search_paths = ['~/wiki']
let g:nv_use_ignore_files = 0

" BibTeX
command! -bar -nargs=1 Doi2bib0 read !doi2bib <args>
" Retab the bib
command! -nargs=1 Doi2bib Doi2bib0 <args> | :normal! vgp<CR> | :retab

" To debug highlight group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
