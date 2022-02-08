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
    if exists('g:nyaovim_version')
        " workaround for nyaovim's weird argv issue
        " ref: https://github.com/rhysd/NyaoVim/issues/142#issuecomment-470254909
        " delete first arg
        execute '1argd'
        " close current buffer
        execute 'bd'

        set clipboard=unnamedplus
        imap <expr> <S-Insert> XTermPasteBegin("")."<C-R>*<f29>"
        cmap <S-Insert> <C-R>*
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

    autocmd BufEnter * lua require('lsp_signature').on_attach()
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#lsp#handler_enabled = v:false

    lua <<EOF
    require('gitsigns').setup({
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 500,
          ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = {
          relative_time = false
        },
    })
EOF

    lua require('Comment').setup()
endif

