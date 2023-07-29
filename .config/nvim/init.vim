set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

set winblend=5
set pumblend=0

if has('win32')
    let $TMP="/tmp"
endif

" highlightedyank
augroup highlight_yank
    autocmd!
    au TextYankPost * lua vim.highlight.on_yank()
augroup END

if has('nvim-0.4.0')
    if exists('g:neoray')
        set guifont=Hack:h10
        NeoraySet CursorAnimTime 0
        NeoraySet WindowState maximized
        NeoraySet ContextMenuOn false
        NeoraySet KeyFullscreen <M-CR>
    endif
    if exists('g:neovide')
        set guifont=Hasklig:h15
        " let g:neovide_fullscreen=v:true
    endif
    if exists('g:started_by_firenvim')
        set guifont=Hack\ Nerd\ Font\ Mono
        set bg=light
        let g:firenvim_config = { 'globalSettings': {}, 'localSettings': { '.*': { 'takeover': 'never' } } }
    endif
    if !exists('*OnUIEnter')
        function! OnUIEnter(event)
            let l:ui = nvim_get_chan_info(a:event.chan)
            if has_key(l:ui, 'client') && has_key(l:ui.client, "name")
                if l:ui.client.name == "Firenvim"
                    source $MYVIMRC
                endif
            endif
        endfunction
    endif
    augroup firenvim
        autocmd!
        autocmd UIEnter * ++nested call OnUIEnter(v:event)
        autocmd BufEnter github.com_*.txt set filetype=markdown
    augroup END
endif

if has('nvim-0.5.0')
    function GitFileStatus()
        let file = expand("%")
        if empty(file)
            return ""
        endif
        let filestatus = system("git status --porcelain " . shellescape(file))
        return filestatus[0:1]
    endfunction

    function RespectGitFileStatus()
        if GitFileStatus() == "UU"
            if exists(':TSBufDisable')
                execute 'TSBufDisable highlight'
            endif
            lua vim.diagnostic.disable(0, nil)
        endif
    endfunction

    augroup respectgit
        autocmd!
        autocmd BufNewFile,BufFilePre,BufRead * call RespectGitFileStatus()
    augroup END

    if !has('win32')
        lua require('treesitter_config')
    endif

    " lua require('onedark_config')
    " lua require('nightfox_config')
    lua require('tokyonight_config')
    colorscheme tokyonight

    lua require('whichkey_config')
    lua require('block_config')

    lua require('fidget_config')
    lua require('mason_config')
    lua require('lsp_config')
    lua require('diagnostics_config')
    lua require('telescope_config')
    lua require('telekasten_config')
    lua require('copilot_config')

    " Note: init lspkind before nvim-cmp
    lua require('lspkind_config')
    lua require('snip_config')
    lua require('cmp_config')
    lua require('null_ls_config')

    lua require('gitsigns_config')
    augroup gitsign
        autocmd!
        autocmd InsertEnter * :Gitsigns toggle_current_line_blame false
        autocmd InsertLeave * :Gitsigns toggle_current_line_blame true
    augroup END

    lua require('Comment').setup()
endif

