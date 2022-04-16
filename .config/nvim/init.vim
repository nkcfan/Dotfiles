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
        set guifont=Hack:h16
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
        nnoremap <silent> <LocalLeader>th       :TSBufToggle highlight<CR>
    endif

    " lua require('onedark_config')
    " lua require('nightfox_config')
    lua require('tokyonight_config')
    colorscheme tokyonight

    lua require('fidget_config')
    lua require('lsp_config')
    nnoremap <silent> <LocalLeader>tv           :lua require("virtual_text").toggle()<CR>
    lua require('diagnostics_config')
    nnoremap <silent> <LocalLeader>td           :lua require("diagnostics_config").toggle()<CR>

    lua require('telescope_config')
    nnoremap <silent> z=                        :Telescope spell_suggest<CR>
    nnoremap <silent> <C-S-PageDown>            :Telescope loclist<CR>
    nnoremap <silent> <S-PageDown>              :Telescope quickfix<CR>
    nnoremap <silent> <M-p>                     <cmd>Telescope buffers<CR>

    " Note: init lspkind before nvim-cmp
    lua require('lspkind_config')
    lua require('snip_config')
    lua require('cmp_config')
    lua require('null_ls_config')

    lua require('telekasten_config')
    nnoremap <LocalLeader>kf :lua require('telekasten').find_notes()<CR>
    nnoremap <LocalLeader>kd :lua require('telekasten').find_daily_notes()<CR>
    nnoremap <LocalLeader>kg :lua require('telekasten').search_notes()<CR>
    nnoremap <LocalLeader>kk :lua require('telekasten').follow_link()<CR>

    " on hesitation, bring up the panel
    nnoremap <LocalLeader>k :lua require('telekasten').panel()<CR>

    lua require('gitsigns_config')
    augroup gitsign
        autocmd!
        autocmd InsertEnter * :Gitsigns toggle_current_line_blame false
        autocmd InsertLeave * :Gitsigns toggle_current_line_blame true
    augroup END

    lua require('Comment').setup()
endif

