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
        set clipboard=unnamedplus
        imap <expr> <S-Insert> XTermPasteBegin("")."<C-R>*<f29>"
        cmap <S-Insert> <C-R>*
        tnoremap <expr> <S-Insert> XTermPasteBegin("").'<C-\><C-N>"*p<f29>i'

        NeoraySet CursorAnimTime 0
        NeoraySet WindowState maximized
        NeoraySet ContextMenuOn false
        NeoraySet KeyFullscreen <M-CR>
    endif
    if exists('g:neovide')
        set guifont=Hasklig:h15
        set clipboard=unnamedplus
        imap <expr> <S-Insert> XTermPasteBegin("")."<C-R>*<f29>"
        cmap <S-Insert> <C-R>*

        " let g:neovide_fullscreen=v:true
    endif
    if exists('g:started_by_firenvim')
        set guifont=Hack:h16
        set clipboard=unnamedplus
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
    if !has('win32')
        lua require('treesitter_config')
        nnoremap <silent> <LocalLeader>th       :TSBufToggle highlight<CR>
    endif

    lua require('lsp_config')
    nnoremap <silent> <LocalLeader>tv           :lua require("virtual_text").toggle()<CR>

    lua require('telescope_config')
    nnoremap <silent> z=                        :Telescope spell_suggest<CR>
    nnoremap <silent> <C-S-PageDown>            :Telescope loclist<CR>
    nnoremap <silent> <S-PageDown>              :Telescope quickfix<CR>
    nnoremap <silent> <M-p>                     <cmd>Telescope buffers<CR>

    " Note: init lspkind before nvim-cmp
    lua require('lspkind_config')
    lua require('diagnostics_config')
    lua require('cmp_config')
    lua require('null_ls_config')

    lua require('telekasten_config')
    nnoremap <LocalLeader>kf :lua require('telekasten').find_notes()<CR>
    nnoremap <LocalLeader>kd :lua require('telekasten').find_daily_notes()<CR>
    nnoremap <LocalLeader>kg :lua require('telekasten').search_notes()<CR>
    nnoremap <LocalLeader>kk :lua require('telekasten').follow_link()<CR>

    " on hesitation, bring up the panel
    nnoremap <LocalLeader>k :lua require('telekasten').panel()<CR>

    lua require('gitsign_config')
    autocmd InsertEnter * :Gitsigns toggle_current_line_blame
    autocmd InsertLeave * :Gitsigns toggle_current_line_blame

    lua require('Comment').setup()
endif

